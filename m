Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965086AbWHQOuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbWHQOuV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbWHQOuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:50:20 -0400
Received: from mailhost.tue.nl ([131.155.2.19]:9411 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S965086AbWHQOuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:50:17 -0400
Message-ID: <44E48224.7050300@etpmod.phys.tue.nl>
Date: Thu, 17 Aug 2006 16:50:12 +0200
From: Bart Hartgers <bart@etpmod.phys.tue.nl>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Nico Schottelius <nico-kernel20060817@schottelius.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Memory bank detection available?
References: <20060817144039.GD19497@schottelius.org>
In-Reply-To: <20060817144039.GD19497@schottelius.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius wrote:
> Hello!
> 
> Is it possible to detect, which memory banks on the mainboard are in use under
> Linux/x86?
> 

dmidecode might do the trick, depending on your BIOS.

Groeten,
Bart

-- 
Bart Hartgers - TUE Eindhoven - http://plasimo.phys.tue.nl/bart/contact/
