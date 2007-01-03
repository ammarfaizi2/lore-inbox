Return-Path: <linux-kernel-owner+w=401wt.eu-S932068AbXACUfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbXACUfL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 15:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbXACUfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 15:35:10 -0500
Received: from main.gmane.org ([80.91.229.2]:60042 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932068AbXACUfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 15:35:09 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Fix shortlog only showing HEAD revision.
Followup-To: gmane.comp.version-control.git
Date: Wed, 03 Jan 2007 21:36:55 +0100
Organization: At home
Message-ID: <enh3v7$ji7$1@sea.gmane.org>
References: <459C0232.3090804@linuxtv.org> <20070103202555.GA25768@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-195.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Cc: git@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Fitzsimons wrote:

> My change in 190d7fdcf325bb444fa806f09ebbb403a4ae4ee6 had a small bug
> found by Michael Krufky which caused the passed in hash value to be
> ignored, so shortlog would only show the HEAD revision.
> 
> Signed-off-by: Robert Fitzsimons <robfitz@273k.net>

Identical change, better commit message (I think).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git


