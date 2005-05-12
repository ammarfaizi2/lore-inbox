Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVELUcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVELUcO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 16:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVELUcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 16:32:14 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:11780 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262107AbVELUcL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 16:32:11 -0400
To: Paul Ionescu <i_p_a_u_l@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: statfs returns wrong values for 250Gb FAT fs
References: <E1DUT2T-0000fm-Nx@localhost.localdomain>
	<20050510080907.GR1998@verge.net.au>
	<87oebjxpcc.fsf@devron.myhome.or.jp>
	<42811AE6.7020902@mail.telepac.pt>
	<pan.2005.05.11.12.23.33.926661@yahoo.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 13 May 2005 05:32:06 +0900
In-Reply-To: <pan.2005.05.11.12.23.33.926661@yahoo.com> (Paul Ionescu's message of "Wed, 11 May 2005 15:23:36 +0300")
Message-ID: <877ji4xk1l.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Ionescu <i_p_a_u_l@yahoo.com> writes:

> I had the same problem with an external 250 GB vfat USB 2.0 disk.
> The disk was formatted/used previously in windows, checkdisk said is OK,
> but mounted in linux readonly, game the same error (said only some little
> space was free, when in fact it was almost full).
> However, I was able to see and copy all files from it.
> As it was not my hard disk, I did not reformatted it, nor dosfsck-ed it.
> DOSFSCK reported errors with the FAT copy, and other errors, but as I
> said, I could access all data on it.

If same problem happen, please report. And please let me investigate
the details of the filesystem of this state.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
