Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271787AbTGRU54 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 16:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271846AbTGRU5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 16:57:50 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:19607 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S271787AbTGRU52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 16:57:28 -0400
Message-ID: <3F18627D.2040604@attbi.com>
Date: Fri, 18 Jul 2003 16:11:25 -0500
From: Tom Zanussi <trz@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Tom Zanussi <zanussi@us.ibm.com>, linux-kernel@vger.kernel.org,
       karim@opersys.com, bob@watson.ibm.com
Subject: Re: [PATCH] relayfs
References: <16148.6807.578262.720332@gargle.gargle.HOWL> <20030716145508.1742d722.shemminger@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> Shouldn't relayfs be in the "Pseudo filesystems" part of Kconfig.
> Also don't need the .ko suffix.
> 

Yeah, I think that makes more sense.  And thanks for your const
filename patch too.

Tom


