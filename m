Return-Path: <linux-kernel-owner+w=401wt.eu-S1161127AbXAEQKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161127AbXAEQKP (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 11:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161139AbXAEQKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 11:10:15 -0500
Received: from mga05.intel.com ([192.55.52.89]:20775 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161127AbXAEQKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 11:10:13 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,243,1165219200"; 
   d="scan'208"; a="184920552:sNHT33143026"
Message-ID: <459E7861.9070803@foo-projects.org>
Date: Fri, 05 Jan 2007 08:10:09 -0800
From: Auke Kok <sofar@foo-projects.org>
User-Agent: Mail/News 1.5.0.9 (X11/20061228)
MIME-Version: 1.0
To: "Renato S. Yamane" <renatoyamane@mandic.com.br>
CC: Akula2 <akula2.shark@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Multi kernel tree support on the same distro?
References: <8355959a0701041146v40da5d86q55aaa8e5f72ef3c6@mail.gmail.com>	 <459D9872.8090603@foo-projects.org>	 <tekrp2tqo78uh6g2pjmrhe0vpup8aalpmg@4ax.com>	 <459DFE9F.9050904@foo-projects.org> <8355959a0701050404t46ff7c56i52737051b8725c74@mail.gmail.com> <459E4455.8050704@mandic.com.br>
In-Reply-To: <459E4455.8050704@mandic.com.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jan 2007 16:10:10.0631 (UTC) FILETIME=[F9946570:01C730E3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Renato S. Yamane wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Em 05-01-2007 10:04, Akula2 escreveu:
>> On 1/5/07, Auke Kok <sofar@foo-projects.org> wrote:
>>> Steve Brueggeman wrote:
>>> gcc 3.4.x works great on both 2.6 and 2.4, no issues whatsoever.
>> Do you mean I need to discard gcc 4.1.x on the distro? Or keep both?
> 
> I use GCC 4.1.2 with vendor Kernel (OpenSuSE) 2.6.18.2 with no problem.
> In next weekend I will compile a new Kernel. 2.6.19.1

I was not saying that *other* compilers don't work, but merely stating that a certain 
version of gcc does really well with BOTH (and most) 2.4 and 2.6 kernel sources. I doubt 
that gcc-4.1.x works all that great with some of the not-so-recent 2.4 kernels.

Auke
