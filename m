Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275148AbRIZKHG>; Wed, 26 Sep 2001 06:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275149AbRIZKG4>; Wed, 26 Sep 2001 06:06:56 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:43018 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S275148AbRIZKGk>; Wed, 26 Sep 2001 06:06:40 -0400
Date: Wed, 26 Sep 2001 10:44:16 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Cc: jc <jcb@jcb.yi.org>
Subject: Re: apm suspend broken in 2.4.10
Message-ID: <20010926104416.D6881@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, jc <jcb@jcb.yi.org>
In-Reply-To: <20010926000023.A2291@athena>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010926000023.A2291@athena>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001, jc wrote:

> it worked fine with 2.4.9
> 
> now with 2.4.10 :
> 
> strace apm -s 

Works for me. Post more information about your system. Did you compile
APM? Did the machine show APM related boot log lines? Or did it use ACPI
perhaps?

BTW, please have your Message-ID contain a full domain name and not just
"athena" to avoid collisions.
