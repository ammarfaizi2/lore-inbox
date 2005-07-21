Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVGUG0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVGUG0u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 02:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVGUG0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 02:26:50 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:51368 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261660AbVGUG0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 02:26:49 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Bastiaan Naber <naber@inl.nl>, linux-kernel@vger.kernel.org
Subject: Re: a 15 GB file on tmpfs
Date: Thu, 21 Jul 2005 09:25:46 +0300
User-Agent: KMail/1.5.4
References: <200507201416.36155.naber@inl.nl>
In-Reply-To: <200507201416.36155.naber@inl.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507210925.46283.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 July 2005 15:16, Bastiaan Naber wrote:
> Hi,
> 
> I am not sure if I can ask this here but I could not find any other place 
> where I could fine anyone with this knowledge.
> 
> I have a 15 GB file which I want to place in memory via tmpfs. I want to do 
> this because I need to have this data accessible with a very low seek time.
> 
> I want to know if this is possible before spending 10,000 euros on a machine 
> that has 16 GB of memory. 

Make large swap file and test it yourself. Not a problem.
--
vda

