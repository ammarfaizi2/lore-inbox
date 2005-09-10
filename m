Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbVIJXq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbVIJXq6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 19:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbVIJXq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 19:46:57 -0400
Received: from smtp04.auna.com ([62.81.186.14]:47796 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S932388AbVIJXq5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 19:46:57 -0400
Date: Sat, 10 Sep 2005 23:46:55 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.13-mm2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
References: <20050908053042.6e05882f.akpm@osdl.org>
In-Reply-To: <20050908053042.6e05882f.akpm@osdl.org> (from akpm@osdl.org on
	Thu Sep  8 14:30:42 2005)
X-Mailer: Balsa 2.3.4
Message-Id: <1126396015l.6300l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.208.222] Login:jamagallon@able.es Fecha:Sun, 11 Sep 2005 01:46:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.08, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm2/
> 
> (kernel.org propagation is slow.  There's a temp copy at
> http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-mm2.bz2)
> 
> 

I can not ifup an interface while iptables is using it.
Is this expected behaviour ?
There is a possible bug (IMHO) in Mandrake initscripts, that start iptables
before network interfaces, but this had always worked.

Any ideas ?

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.13-jam3 (gcc 4.0.1 (4.0.1-5mdk for Mandriva Linux release 2006.0))


