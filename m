Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWEUNiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWEUNiQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 09:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWEUNiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 09:38:15 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:56733 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964870AbWEUNiP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 09:38:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mNqqPXU9FpzwYRSelZ6ByVv2NGmjGuoXGoNV2DTj/1mLGYg7FE8LCbSnT5fAhwhKWfjK6FkB2HoDRmLNyz1PYDqRY3AveHLIQRtIku/mwbeuyxSnSSuvJUAT2xQVbhPbTdk2Dm46DXzqJVHc44UMiEbSYh2ze+X6v2aSEw4XRDk=
Message-ID: <5486cca80605210638l2906112fv515df1bc390cff24@mail.gmail.com>
Date: Sun, 21 May 2006 15:38:12 +0200
From: Antonio <tritemio@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [radeonfb]: unclean backward scrolling
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using the radeonfb driver with a radeon 7000 with the frambuffer
at 1280x1024 on a i386 system, with a 2.6.16.17 kernel. At boot time,
if I stop the messages with CTRL+s and try look the previous messages
with CTRL+PagUp (backward scrolling) the screen become unreadable. In
fact some lengthier lines are not erased scrolling backward and some
random characters a overwritten instead. So it's very difficult to
read the messages.

I don't have such problem with the frambuffer at 1024x768.

All the previous kernels I've tried have this problem (at least up to 2.6.15).

If someone can look at this issue I can provide further information.

Many Thanks.

Cheers,

  ~ Antonio
