Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVASTkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVASTkI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 14:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVASTkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 14:40:08 -0500
Received: from web53803.mail.yahoo.com ([206.190.36.198]:38793 "HELO
	web53803.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261493AbVASTig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 14:38:36 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=CvPubSWP7u4H4BpAra4vL8WatOsb1zwTZkKut4CFbrstz+kghX+rgC5h3RCw+l2EPjMJQ6sfMuPhKrhy1WIjsgx4uh4runnSsZMenWXTUcIZQ+dSmi1Ypx5SffOin3ncrEFxTh4MD/W6vR8sxNJ4pVfA1H/xDt56AwhFXLfXtDw=  ;
Message-ID: <20050119193832.34975.qmail@web53803.mail.yahoo.com>
Date: Wed, 19 Jan 2005 11:38:32 -0800 (PST)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: [ANNOUNCE] Linux-tracecalls, a new tool for Kernel development, released
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From http://www.linuxrd.com/~carl/cgi-bin/lnxtc.pl?help

"'LINUX-TRACECALLS' finds all call chains leading to a given function in the Linux
kernel, to some arbitrary depth. It consists of two parts - a set of specially
prepared cscope databases for the kernel source tree, and a perl program, 'lnxtc.pl',
to do the call chain discovery based on the information in the cscope DBs."

"It works, in part, by expanding function-yielding macros and by mangling function names
with the name of the file containing the function's definition, prior to creating the
cscope files."

"It is believed to be highly accurate.."


