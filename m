Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbTEFDrV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 23:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbTEFDrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 23:47:21 -0400
Received: from 12-226-168-214.client.attbi.com ([12.226.168.214]:46277 "EHLO
	marta.kurtwerks.com") by vger.kernel.org with ESMTP id S262310AbTEFDrP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 23:47:15 -0400
Date: Mon, 5 May 2003 23:54:50 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: Sumit Narayan <sumit_uconn@lycos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inode number
Message-ID: <20030506035450.GU21898@kurtwerks.com>
References: <MHCBNPOFCDJPBDAA@mailcity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MHCBNPOFCDJPBDAA@mailcity.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.20-xfs
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An unnamed Administration source, Sumit Narayan, wrote:
% Hi,
% 
% Actually, what I meant with this was, suppose I have a file name, how do I get the inode for that? And also suppose I have the inode number, how do I get the complete object of that inode for use and manipulation?

If you have a filename, stat(2); see also lstat(2) and fstat(2).

Kurt
-- 
Error in operator: add beer
