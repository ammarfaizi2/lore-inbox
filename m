Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbUKQWI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbUKQWI7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbUKQWI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:08:58 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:28457 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262633AbUKQWIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:08:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=FMFl9sOZ+Nm6vSBB2uMhBOJTFbueGOQ2pz8ef4wOWTQSM94mJaBtb6gBLnJ5ydftjg/zZW8W3CuRexK5IdntHWzVw6vScd2HxVDkfg1tncvRQTQQaNv0W1ZVHZ2F88omz4rNV8EGL0cJ0kJPHbZpcwIbjO5douQAmaENprl1bPo=
Message-ID: <58cb370e0411171408449b419c@mail.gmail.com>
Date: Wed, 17 Nov 2004 23:08:20 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] documentation - ide params
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <aec7e5c304111606282acf7f6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <aec7e5c304111606282acf7f6c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004 15:28:42 +0100, Magnus Damm <magnus.damm@gmail.com> wrote:
> Hello again,
> 
> This patch removes ide parameters marked as obsolete in the source and
> adds documentation for "ide=". I think I got it right, the important
> part for me is "ide=nodma".

applied
