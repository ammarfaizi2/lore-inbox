Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUG1GZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUG1GZT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 02:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266218AbUG1GZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 02:25:19 -0400
Received: from mailhub2.uq.edu.au ([130.102.149.128]:60434 "EHLO
	mailhub2.uq.edu.au") by vger.kernel.org with ESMTP id S266183AbUG1GZP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 02:25:15 -0400
From: Ben Hoskings <s4010227@student.uq.edu.au>
To: linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
Date: Wed, 28 Jul 2004 16:25:04 +1000
User-Agent: KMail/1.6.2
References: <E1Bouyq-0001OQ-00@calista.eckenfels.6bone.ka-ip.net>
In-Reply-To: <E1Bouyq-0001OQ-00@calista.eckenfels.6bone.ka-ip.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407281625.05083.s4010227@student.uq.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 July 2004 12:12, Bernd Eckenfels wrote:
> In article <200407261138.55020.ben@jeeves.gotdns.org> you wrote:
> > I think the idea of forking off certain releases in the 2.6.x.0 form, to
> > only recieve bugfixes and security updates, is a very good idea.
>
> Leave that to the vendors, they already do that.
>
> Whats wrong with adding features which touch major parts of the code only
> to 2.7, and perhaps bacport them if they proof to be worth it?

I guess it's pretty similar in practice. I brought it up because the idea of 
freezing releases at 2.6.x.0 is more fine-grained, and as such it seemed to 
me that it would be less of a maintenance overhead.

Although labels aside, I suppose the two systems are acheiving the same thing 
in the end.

>
> Greetings
> Bernd

--
	Ben
