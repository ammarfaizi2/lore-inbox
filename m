Return-Path: <linux-kernel-owner+w=401wt.eu-S1030440AbXAHBzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030440AbXAHBzI (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 20:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030442AbXAHBzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 20:55:08 -0500
Received: from main.gmane.org ([80.91.229.2]:34503 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030440AbXAHBzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 20:55:04 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How git affects kernel.org performance
Followup-To: gmane.comp.version-control.git
Date: Mon, 08 Jan 2007 02:51:42 +0100
Organization: At home
Message-ID: <ens836$jr2$1@sea.gmane.org>
References: <20061214223718.GA3816@elf.ucw.cz> <20061216094421.416a271e.randy.dunlap@oracle.com> <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain> <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com> <20070107145730.GB24706@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-145.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Cc: git@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Fitzsimons wrote:

>> Some more data on how git affects kernel.org...
> 
> I have a quick question about the gitweb configuration, does the
> $projects_list config entry point to a directory or a file?

It can point to both. Usually it is either unset, and then we
do find over $projectroot, or it is a file (URI escaped path
relative to $projectroot, SPACE, and URI escaped owner of a project;
you can get the file clicking on TXT on projects_list page).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git


