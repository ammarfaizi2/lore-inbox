Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWERTZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWERTZL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 15:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWERTZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 15:25:11 -0400
Received: from jacks.isp2dial.com ([64.142.120.55]:4868 "EHLO
	jacks.isp2dial.com") by vger.kernel.org with ESMTP id S1751384AbWERTZK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 15:25:10 -0400
From: John Kelly <jak@isp2dial.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, xemul@sw.ru, haveblue@us.ibm.com, clg@fr.ibm.com,
       serue@us.ibm.com
Subject: Re: [PATCH 0/9] namespaces: Introduction
Date: Thu, 18 May 2006 15:23:20 -0400
Message-ID: <200605181923.k4IJNL5a007645@isp2dial.com>
References: <20060518154700.GA28344@sergelap.austin.ibm.com> <20060518103430.080e3523.akpm@osdl.org>
In-Reply-To: <20060518103430.080e3523.akpm@osdl.org>
X-Mailer: Forte Agent 1.93/32.576 English (American)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Hard2Crack: 0.001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2006 10:34:30 -0700, Andrew Morton <akpm@osdl.org>
wrote:

>I see two ways of justifying a mainline merge of things such as this

>a) We make an up-front decision that Linux _will_ have OS-virtualisation
>   capability in the future

After using OpenVZ for a short time, I wonder how I ever managed
without it.  For application development and testing, having a little
sandbox with only a few PIDs running makes it easier to debug things.


> and just start putting in place the pieces for that, even if some
> of them are not immediately useful.  I suspect that'd be acceptable,
> although I worry that we'd get partway through and some issues would
> come up which are irreconcilable amongst the various groups.

>From a user's POV, I want it ASAP.  As for conflicts, why not cross
that bridge when you come to it?


