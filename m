Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbUAMBsM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 20:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbUAMBsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 20:48:12 -0500
Received: from pengo.systems.pipex.net ([62.241.160.193]:41658 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S263513AbUAMBsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 20:48:08 -0500
From: Roman Gaufman <hackeron@dsl.pipex.com>
Reply-To: hackeron@dsl.pipex.com
To: linux-kernel@vger.kernel.org
Subject: Slow NFS performance over wireless!
Date: Tue, 13 Jan 2004 01:55:32 +0000
User-Agent: KMail/1.5.94
References: <Pine.LNX.4.44.0401060055570.1417-100000@poirot.grange>
In-Reply-To: <Pine.LNX.4.44.0401060055570.1417-100000@poirot.grange>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401130155.32894.hackeron@dsl.pipex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I have experienced extremely poor NFS performance over wireless, when I scp a 
piece of information from server to laptop, transfer rates stay stable and 
file transfers, when I use NFS transfer rates jump constantly, and most of 
the time file is NOT transfering.

I have searched all over the nfs, enabled higher caching on nfs, enabled the 
usage of tcp, tried to pass hard, but transfer rates very poor, and only for 
nfs transfer, so it doesn't seem my network configurations are wrong as scp, 
html, ftp seem to work on full speed.

On other machines on the network (non wireless) running same kernel (2.6.0) 
everything seems fine.

Can anyone suggest what I could test to trace this problem?
