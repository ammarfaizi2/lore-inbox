Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbUAYQD2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 11:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264459AbUAYQD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 11:03:28 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:33299 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S264454AbUAYQD1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 11:03:27 -0500
To: Marc Mongenet <Marc.Mongenet@freesurf.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.25pre7 - cannot mount 128MB vfat fs on Minolta camera
References: <4013D155.3080900@freesurf.ch>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 26 Jan 2004 01:03:01 +0900
In-Reply-To: <4013D155.3080900@freesurf.ch>
Message-ID: <87y8rw2eyy.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Mongenet <Marc.Mongenet@freesurf.ch> writes:

> Hi, I have a Minolta DiMAGE F100 camera and two memory cards,
> a 16 MB and a 128 MB.
> With kernel 2.2.25 I can mount the 16 MB but not the 128 MB.
> With kernel 2.4.16 to 2.4.25pre6 I can mount the 128 MB but not the 16 MB.
> With kernel 2.4.25pre7 I can mount the 16 MB but not the 128 MB.
> 
> There is probably something special with the filesystem used by Minolta
> because I have to format it with the camera to be recognized by the camera.

What error did you get? Please send output of dmesg and first
256KB of 128MB card.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
