Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265003AbUD2WZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265003AbUD2WZJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 18:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265004AbUD2WZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 18:25:09 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:31118 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S265003AbUD2WZB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 18:25:01 -0400
In-Reply-To: <200404292347.17431.koke_lkml@amedias.org>
References: <Pine.LNX.4.44.0404291114150.9152-100000@chimarrao.boston.redhat.com> <4FE43C97-9A20-11D8-B804-000A95CD704C@wagland.net> <4091757B.3090209@techsource.com> <200404292347.17431.koke_lkml@amedias.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0CAE0144-9A2C-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: Paul Wagland <paul@wagland.net>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>, Rik van Riel <riel@redhat.com>,
       David Gibson <david@gibson.dropbear.id.au>,
       Timothy Miller <miller@techsource.com>
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Thu, 29 Apr 2004 18:24:58 -0400
To: koke@sindominio.net
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The inherent instability of binary modules is a religious myth. Any 
module can be stable or unstable, depending on how it's written, tested 
and the environment (hardware/evolving APIs it depends on). For 
example, Apple's current Mac OS X is extremely stable imho, despite the 
fact that their hardware drivers are generally binary-only.

The same goes for trustworthiness. It's a matter of point of view / 
preference whether you trust open-source projects and their security 
(which can be far from perfect, as evidenced by the recent break-ins in 
various servers hosting source repositories) more than stuff produced 
by a corporation. Every model has disadvantages and advantages. 
Responsible projects, people and corporations usually all care a lot 
about their reputation and can be trustworthy, regardless of the 
specific form in which they distribute software.

I think that Rik is right when saying that the key information that 
should be conveyed is who is responsible for providing support. The 
wording should be kept neutral, without negative connotation nor 
religious bias.

Marc

On Apr 29, 2004, at 5:47 PM, Jorge Bernal (Koke) wrote:

> On Jueves, 29 de Abril de 2004 23:36, Timothy Miller wrote:
>>
>> Hmmm... how about "untrusted"?  Not sure...
>>
>
> I like "untrusted". Another option is some like "binary only modules 
> can make
> your system unstable and kernel developers have nothing to do with 
> that" (but
> well written, and shorter if possible).
>
> -- 
> Jorge Bernal aka. Koke
> koke@amedias.org // koke@sindominio.net
> JID: koke@zgzjabber.ath.cx
>

