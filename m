Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318371AbSGRVMg>; Thu, 18 Jul 2002 17:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318372AbSGRVMg>; Thu, 18 Jul 2002 17:12:36 -0400
Received: from ns.suse.de ([213.95.15.193]:59914 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318371AbSGRVMg>;
	Thu, 18 Jul 2002 17:12:36 -0400
Date: Thu, 18 Jul 2002 23:15:30 +0200
From: Dave Jones <davej@suse.de>
To: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
Cc: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>, RSinko@island.com,
       DHubbard@midamerican.com, linux-kernel@vger.kernel.org
Subject: Re: Wrong CPU count
Message-ID: <20020718231530.H21997@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>,
	"Holzrichter, Bruce" <bruce.holzrichter@monster.com>,
	"'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>, RSinko@island.com,
	DHubbard@midamerican.com, linux-kernel@vger.kernel.org
References: <61DB42B180EAB34E9D28346C11535A783A7CAE@nocmail101.ma.tmpw.net> <Pine.LNX.4.44.0207181657590.28305-100000@alumno.inacap.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207181657590.28305-100000@alumno.inacap.cl>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 04:59:14PM -0400, Robinson Maureira Castillo wrote:

 > And that arises a question for me too, can we enable/disable HT at boot 
 > time? (think in a mobo without the option to enable/disable HT)

You can disable it with 'noht'.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
