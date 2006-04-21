Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWDUQIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWDUQIN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWDUQIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:08:12 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:49636 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932385AbWDUQIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:08:10 -0400
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for run-time
	authentication of binaries
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Makan Pourzandi <Makan.Pourzandi@ericsson.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Serue Hallyen <serue@us.ibm.com>,
       Axelle Apvrille <axelle_apvrille@rc1.vip.ukl.yahoo.com>,
       "'disec-devel@lists.sourceforge.net'" 
	<disec-devel@lists.sourceforge.net>
In-Reply-To: <4448AC62.6090303@ericsson.com>
References: <4448AC62.6090303@ericsson.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 21 Apr 2006 12:12:37 -0400
Message-Id: <1145635957.21749.154.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 09:56 +0000, Makan Pourzandi wrote:
> Hi,
> 
> Digsig development team would like to announce the release 1.5 of digsig.
> 
> This kernel module helps system administrators control Executable and 
> Linkable Format (ELF) binary execution and library loading based on
> the presence of a valid digital signature.  The main functionality is
> to help system administrators distinguish applications he/she trusts
> (and therefore signs) from viruses, worms (and other nuisances). It is
> based on the Linux Security Module hooks.
> 
> The code is GPL and available from:
> http://sourceforge.net/projects/disec/, download digsig-1.5. For
> more documentation, please refer to disec.sourcefrge.net.
> 
> We hope that it'll be useful to you.
> 
> All bug reports and feature requests or general feedback are welcome
> (please CC me and disec-devel@lists.sourceforge.net in your answer or 
> feedback to the mailing list).

That URL doesn't seem to be working at present.
You should submit your security module for mainline; otherwise, LSM
might be removed.  See
http://marc.theaimsgroup.com/?l=linux-security-module&m=114530167302454&w=2

Also discussed on lwn.net.

-- 
Stephen Smalley
National Security Agency

