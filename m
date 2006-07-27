Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751888AbWG0SiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbWG0SiJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbWG0SiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:38:08 -0400
Received: from atpro.com ([12.161.0.3]:50960 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1751888AbWG0SiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:38:07 -0400
Date: Thu, 27 Jul 2006 14:37:33 -0400
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Luigi Genoni <genoni@sns.it>
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@stusta.de>,
       andrea@cpushare.com, "J. Bruce Fields" <bfields@fieldses.org>,
       Hans Reiser <reiser@namesys.com>, Nikita Danilov <nikita@clusterfs.com>,
       Rene Rebe <rene@exactcode.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: the ' 'official' point of view' expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060727183733.GA21439@voodoo.jdc.home>
Mail-Followup-To: Luigi Genoni <genoni@sns.it>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	Adrian Bunk <bunk@stusta.de>, andrea@cpushare.com,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Hans Reiser <reiser@namesys.com>,
	Nikita Danilov <nikita@clusterfs.com>, Rene Rebe <rene@exactcode.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <genoni@sns.it> <2870.192.167.206.189.1153998447.squirrel@darkstar.linuxpratico.net> <200607271330.k6RDUaPC008087@laptop13.inf.utfsm.cl> <4095.192.167.206.189.1154010667.squirrel@darkstar.linuxpratico.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4095.192.167.206.189.1154010667.squirrel@darkstar.linuxpratico.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/27/06 04:31:07PM +0200, Luigi Genoni wrote:
> Since reiser4 is not something enabled by default into a default kernel
> distribution, I assume they enabled it knowing what they where doing because
> they wanted to use it.
> 
> 

Or because they did 'allmodconfig' or 'allyesconfig'. Whenever I build
a kernel I enabled everything possible as a module in case I ever need
it. For instance, a few weeks ago I had the reiserfs module loaded because
I was testing something, if I had klive running it would have said that I
use reiserfs when in fact I don't.

Jim.
