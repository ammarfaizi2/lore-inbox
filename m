Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbUKJOEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbUKJOEp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbUKJODC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:03:02 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:33117 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261943AbUKJN4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:56:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=lRbQhzsjF/Q1xo8lR3vyM+FbdFJLb0XjmkVN5L06EC7YQdR3ZVJA40znXEoI8gwHRzToZg0dVK0wV+ynz8hkQKSxE9xy/h2Bq2CWXDseRD6WXKtl6tr0QBUVsIHkTOH47V2PPQFIuQp6lYHzi6b9wZHGWQPuaEFwU9k84mG0FIA=
Message-ID: <889bec7e0411100556707a9d97@mail.gmail.com>
Date: Wed, 10 Nov 2004 14:56:02 +0100
From: HoWE <nackas@gmail.com>
Reply-To: HoWE <nackas@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Begginer need help 2.6
In-Reply-To: <d5a95e6d041110053276820b92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <d5a95e6d041110053276820b92@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2004 10:32:52 -0300, Diego <foxdemon@gmail.com> wrote:
> Sorry bothering but somebody can help me, i need to know if exist in
> kernel a variable ou something that can inform the CPU idle time (like
> top informs) and where is it, so i can use it.

an answer to this most certainly exists in the archives already.

take a look in /usr/src/linux-2.6.X/Documentation/filesystems/proc.txt,
search for /proc/stat
