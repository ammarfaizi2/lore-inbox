Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262594AbUKLSBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbUKLSBz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 13:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbUKLSBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 13:01:55 -0500
Received: from ns.focomunicatii.ro ([212.146.75.6]:36567 "HELO
	focomunicatii.ro") by vger.kernel.org with SMTP id S261660AbUKLSA6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 13:00:58 -0500
Message-ID: <20041112175911.24846.qmail@focomunicatii.ro>
References: <20041107214427.20301.qmail@focomunicatii.ro>
            <20041107224803.GA29248@electric-eye.fr.zoreil.com>
            <20041109000006.GA14911@electric-eye.fr.zoreil.com>
            <20041109232510.GA5582@electric-eye.fr.zoreil.com>
            <20041110201010.18341.qmail@focomunicatii.ro>
            <20041110212835.GA23758@electric-eye.fr.zoreil.com>
            <20041110230853.GB23758@electric-eye.fr.zoreil.com>
            <20041111073754.27966.qmail@focomunicatii.ro>
            <20041111095102.GA2280@electric-eye.fr.zoreil.com>
In-Reply-To: <20041111095102.GA2280@electric-eye.fr.zoreil.com>
From: sebastian.ionita@focomunicatii.ro
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: seby@focomunicatii.ro, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       alan@redhat.com, jgarzik@pobox.com
Subject: Re: ZyXEL GN650-T
Date: Fri, 12 Nov 2004 19:59:11 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu writes: 

> sebastian.ionita@focomunicatii.ro <sebastian.ionita@focomunicatii.ro> :
> [...]
>> Later i will restart the server with the new kernel and i will tell you if 
>> something gets bad or if it will work ... :) 
> 
> If it does not work as expected, please describe the minimal level of
> operation which is ok (i.e. networking without vlan for instance). 
> 
> The range of possible errors should be rather limited: mostly gross
> typos or endianness issues when mucking with vlan related registers
> (I am not too sure about the layout of the VID for Rx/Tx).
Without vlan's it works but with vlan the behavier is just like with the old 
drivers. Shoud I give some param's to the module if want to have vlans ?
> 
> --
> Ueimor
 


____________________________________________________________
SC. FO Comunicatii SRL.
Sebastian Ionita
Administrator Sistem
mobil: 0724 212408
tel fix: 0264 450456 


