Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbTELXXL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 19:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTELXXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 19:23:11 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:7418 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262941AbTELXXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 19:23:10 -0400
Date: Mon, 12 May 2003 16:38:21 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: "Mukker, Atul" <atulm@lsil.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: unique entry points for all driver hosts
Message-ID: <20030512233821.GF3226@beaverton.ibm.com>
Mail-Followup-To: "Mukker, Atul" <atulm@lsil.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0E3FA95632D6D047BA649F95DAB60E570185F192@EXA-ATLANTA.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570185F192@EXA-ATLANTA.se.lsil.com>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mukker, Atul [atulm@lsil.com] wrote:
> Why doesn't mid-layer allow LLDs to specify separate entry points to various
> hosts attached to the same driver. Like some other entries in the Scsi Host
> Template, entry points should also  allowed to be overridden.
> 
> 
> Thanks

Is there a issue you are hitting of common host template functions and
selecting unique host instance functions using hostdata?

-andmike
--
Michael Anderson
andmike@us.ibm.com

