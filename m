Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266011AbUF2UKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266011AbUF2UKG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 16:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266010AbUF2UKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 16:10:05 -0400
Received: from holomorphy.com ([207.189.100.168]:18858 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266011AbUF2UJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 16:09:44 -0400
Date: Tue, 29 Jun 2004 13:09:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Brian <bmg300@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel VM bug?
Message-ID: <20040629200922.GX21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Brian <bmg300@yahoo.com>, linux-kernel@vger.kernel.org
References: <20040628025832.GM21066@holomorphy.com> <20040629200525.25773.qmail@web41504.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040629200525.25773.qmail@web41504.mail.yahoo.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 01:05:25PM -0700, Brian wrote:
> GRASS also has problems on the 2.6.7 kernel.
> My system is an Athlon-XP with 512MB RAM running Slackware 10.0.0
> (kernel 2.4.26) full installation in X windows with minimal window
> manager and minimal other processes.
> To reproduce:
> Download the NASA blue marble from

Okay, I'll get onto fixing this. My IRQ stack overfloweth.


-- wli
