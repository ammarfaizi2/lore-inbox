Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293540AbSBZIh6>; Tue, 26 Feb 2002 03:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293544AbSBZIht>; Tue, 26 Feb 2002 03:37:49 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:39330 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S293543AbSBZIhf>; Tue, 26 Feb 2002 03:37:35 -0500
From: Christoph Rohland <cr@sap.com>
To: Shawn Starr <spstarr@sh0n.net>
Cc: Linux <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the
 tree
In-Reply-To: <200202260135.18913.Dieter.Nuetzel@hamburg.de>
	<1014686150.18834.2.camel@coredump>
Organisation: SAP LinuxLab
Date: Tue, 26 Feb 2002 09:36:58 +0100
In-Reply-To: <1014686150.18834.2.camel@coredump> (Shawn Starr's message of
 "25 Feb 2002 20:15:48 -0500")
Message-ID: <m3wux0bpw5.fsf@linux.wdf.sap-ag.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On 25 Feb 2002, Shawn Starr wrote:
> Not to begin the flamewar, but no thanks. rmap-12f blows -aa away
> AFAIK on this P200 w/ 64MB ram.

Please don't repeat the errors of the past. 

-- rmap should evolve some time more. We should keep it in a safe area
   for a while to mature without being distracted by user confusion.
-- aa seams to be the needed fix for the current design

So please add the needed fixes for the current design and wait for the
next design to become ready.

Greetings
		Christoph


