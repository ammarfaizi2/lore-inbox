Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbTHTRg6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 13:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbTHTRg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 13:36:58 -0400
Received: from 213-0-201-211.dialup.nuria.telefonica-data.net ([213.0.201.211]:53134
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S262112AbTHTRg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 13:36:56 -0400
Date: Wed, 20 Aug 2003 19:36:39 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Connection tracking for IPSec
Message-ID: <20030820173639.GA4436@localhost>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
References: <1061378568.668.9.camel@teapot.felipe-alfaro.com> <1061381498.4210.16.camel@chtephan.cs.pocnet.net> <1061389376.3804.16.camel@teapot.felipe-alfaro.com> <1061391227.5558.2.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061391227.5558.2.camel@chtephan.cs.pocnet.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 20 August 2003, at 16:53:47 +0200,
Christophe Saout wrote:

> These packets should get reinjected into the netfilter mechanism after
> decryption and should pass the rules before getting encrypted.
> 
I don't know if this is possible or even desireable, but if you want to
have an answer from the people who cares and works most on Linux's net
support, you should at least Cc: linux-net@vger.kernel.org, where Linux
network development occurs.

Regards,

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test3-mm2)
