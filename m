Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbUAURMb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 12:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266089AbUAURMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 12:12:30 -0500
Received: from moraine.clusterfs.com ([66.246.132.190]:39875 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S263861AbUAURM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 12:12:29 -0500
Date: Wed, 21 Jan 2004 10:12:27 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Esben Stien <executiv@online.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: logging all input and output on a tty
Message-ID: <20040121171227.GO19425@schnapps.adilger.int>
Mail-Followup-To: Esben Stien <executiv@online.no>,
	linux-kernel@vger.kernel.org
References: <87ad4h5juk.fsf@online.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ad4h5juk.fsf@online.no>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 21, 2004  17:48 +0100, Esben Stien wrote:
> I've been trying to get an answer to tty logging for a long time
> without anyone able to answer. I want to log everything that is written
> to and from a certain tty. I expect this to be a kernel module. Anyone
> have any pointers where I can look?. Is there an existing module?

This can be done relatively easily in userspace via "script" or "screen".

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

