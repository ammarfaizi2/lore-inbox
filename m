Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVGVLlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVGVLlj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 07:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVGVLlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 07:41:39 -0400
Received: from ns.firmix.at ([62.141.48.66]:16802 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S262080AbVGVLli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 07:41:38 -0400
Subject: Re: Kernel doesn't free Cached Memory
From: Bernd Petrovitsch <bernd@firmix.at>
To: Vinicius <jdob@ig.com.br>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050722_112730_062779.jdob@ig.com.br>
References: <20050722_112730_062779.jdob@ig.com.br>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Fri, 22 Jul 2005 13:41:31 +0200
Message-Id: <1122032491.22878.4.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-22 at 08:27 -0300, Vinicius wrote:
[...]
>    I have a server with 2 Pentium 4 HT processors and 32 GB of RAM, this 
> server runs lots of applications that consume lots of memory to. When I stop 
> this applications, the kernel doesn't free memory (the  memory still in use) 
> and the server cache lots of memory (~27GB). When I start this applications, 
> the kernel sends  "Out of Memory" messages and kill some random 
> applications. 
> 
>    Anyone know how can I reduce the kernel cached memory on RHEL 3 (kernel 
> 2.4.21-32.ELsmp - Trial version)? There is a way to reduce the kernel cached 
> memory utilization? 

Probably RedHat's support can answer this for RHEL 3.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

