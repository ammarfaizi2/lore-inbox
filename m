Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266386AbUHSO5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266386AbUHSO5p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 10:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266311AbUHSOy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 10:54:57 -0400
Received: from 213-0-217-234.dialup.nuria.telefonica-data.net ([213.0.217.234]:20615
	"EHLO localhost") by vger.kernel.org with ESMTP id S266347AbUHSOym
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 10:54:42 -0400
Date: Thu, 19 Aug 2004 16:54:37 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Crash using Kernel 2.8.1 and HTB
Message-ID: <20040819145437.GA7539@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <41249570.20208@apartia.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41249570.20208@apartia.fr>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 19 August 2004, at 13:56:32 +0200,
Laurent CARON wrote:

> My computer boots fine, but when I enable HTB (via Fiaif) the computer 
> hangs.
> Did anyone get the same problem?
> 
It seems you have been bitten by a known bug, which Dave S. Miller
patched a couple of days ago. See the following thread:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109263832828196&w=2

Greetings.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.8.1-vp)
