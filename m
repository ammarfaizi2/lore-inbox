Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbULEXm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbULEXm5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 18:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbULEXm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 18:42:57 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:3814 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261429AbULEXmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 18:42:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=KVK0525lQgCDpt0xrgrgJ7PyuSUaPLg2tx8hiKjUaT/lHIDYBrB9ayBhCC8QaIyMHahLqc1TGciwib8AKCxZPhQkYf6dY2hFojM4vr2wZsT3HKjTwrOo4Lb6kLImM/EoQzGKfjOP7mcupT0LfobNpFASaBKZUlXVdQIGIkFWMRI=
Message-ID: <35fb2e59041205154242e2af2@mail.gmail.com>
Date: Sun, 5 Dec 2004 23:42:43 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: krishna <krishna.c@globaledgesoft.com>
Subject: Re: UML debugging session
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41B30ECB.8070907@globaledgesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41B30ECB.8070907@globaledgesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Dec 2004 19:06:11 +0530, krishna
<krishna.c@globaledgesoft.com> wrote:

> I installed UML on my system.
> I am not able to use it properly for debugging,

> linux-2.4.26# gdb linux

Did you read the instructions on the UML website however? You'll need to do:

linux debug

Which will nicely handle the gdb startup for you and give you a gdb xterm.

Jon.
