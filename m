Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278698AbRJXSLz>; Wed, 24 Oct 2001 14:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278697AbRJXSLf>; Wed, 24 Oct 2001 14:11:35 -0400
Received: from maild.telia.com ([194.22.190.101]:61888 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S278695AbRJXSLb>;
	Wed, 24 Oct 2001 14:11:31 -0400
Date: Thu, 25 Oct 2001 20:15:08 +0200
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
To: Linux-Kernel Development Mailinglist 
	<linux-kernel@vger.kernel.org>
Subject: Re: 2.4.13: some compilerwarnings...
Message-ID: <20011025201508.B11646@telia.com>
Mail-Followup-To: Linux-Kernel Development Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20011024195342.A464@Zenith.starcenter>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011024195342.A464@Zenith.starcenter>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Vermeulen <sven.vermeulen@rug.ac.be> wrote:

> {standard input}:1040: Warning: indirect lcall without `*'
> {standard input}:1125: Warning: indirect lcall without `*'
> {standard input}:1208: Warning: indirect lcall without `*'

I think Alan once mentioned that this was sort of a feature to make old
versions of binutils work too. I'm not sure exactly how old those are
though, and if they are older than the recommended 2.9.1.0.25 I vote for
fixing these ugly warnings.
-- 

André Dahlqvist <andre.dahlqvist@telia.com>
