Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272579AbTHNSZH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 14:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272966AbTHNSZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 14:25:06 -0400
Received: from guug.galileo.edu ([168.234.203.30]:55049 "EHLO guug.galileo.edu")
	by vger.kernel.org with ESMTP id S272579AbTHNSZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 14:25:05 -0400
Date: Thu, 14 Aug 2003 12:19:47 -0600
To: Alasdair McWilliam <allymcw2000@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Unresolved symbols of _mmx_memcpy in modules on an Athlon XP system
Message-ID: <20030814181947.GA7862@guug.org>
References: <Law10-F417rkWLoLBNJ0005120b@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Law10-F417rkWLoLBNJ0005120b@hotmail.com>
User-Agent: Mutt/1.5.4i
From: Otto Solares <solca@guug.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 04:22:37PM +0100, Alasdair McWilliam wrote:
> The configuration file has never been setup for an Intel chip, it was 
> originally an AMD K6-II/500MHz. I've tried reconfiguring from a brand new 
> tarball for Athlon. What do I get?

Anyway as they are different sub-archs you must do a mrproper
first, then make normally.

-solca

