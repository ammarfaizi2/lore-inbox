Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWBYAtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWBYAtV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 19:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWBYAtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 19:49:20 -0500
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:45018 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964826AbWBYAtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 19:49:19 -0500
Date: Fri, 24 Feb 2006 19:46:19 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Looking for a file monitor
To: Hareesh Nagarajan <hnagar2@gmail.com>
Cc: Diego Calleja <diegocg@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200602241949_MC3-1-B93F-2159@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <43FF3C1C.5040200@gmail.com>

On Fri, 24 Feb 2006 at 11:02:20 -0600, Hareesh Nagarajan wrote:

> But if we want to keep a track of all the files that are opened, read, 
> written or deleted (much like filemon; ``Filemon's timestamping feature 
> will show you precisely when every open, read, write or delete, happens, 
> and its status column tells you the outcome."), we can write a simple 
> patch that makes a note of these events on the VFS layer, and then we 
> could export this information to userspace, via relayfs. It wouldn't be 
> too hard to code a relatively efficient implementation.

 Doesn't auditing do all this?

 I have Fedora Core 4 installed and it comes with the 'audit' RPM.

-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert

