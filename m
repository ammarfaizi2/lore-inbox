Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269050AbTCAWZA>; Sat, 1 Mar 2003 17:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269054AbTCAWZA>; Sat, 1 Mar 2003 17:25:00 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:2535 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S269050AbTCAWY6>; Sat, 1 Mar 2003 17:24:58 -0500
Date: Sun, 02 Mar 2003 11:35:29 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Stephen Corey <s_corey@netzero.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel tuning for high latency satellite link??
Message-ID: <132088132.1046604929@[192.168.0.1]>
In-Reply-To: <000001c2e00b$71bb7d50$0301a8c0@corey>
References: <000001c2e00b$71bb7d50$0301a8c0@corey>
X-Mailer: Mulberry/3.0.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It should do OK by default, but you might want to read RFC 3150 for some 
ideas for things to do to help.

Andrew

--On Saturday, 1 March 2003 10:58 a.m. -0500 Stephen Corey 
<s_corey@netzero.com> wrote:

> Do I need to tune the linux kernel (2.4.18-3) for high latency
> connections? I'm installing a linux box on a satellite link (~800 ms
> roundtrip latency). Will the kernel *automatically* change anything
> based on latency, to hurt my throughput performance??
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


