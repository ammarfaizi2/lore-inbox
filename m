Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267268AbSK3QNg>; Sat, 30 Nov 2002 11:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267267AbSK3QNg>; Sat, 30 Nov 2002 11:13:36 -0500
Received: from rrcs-midsouth-24-172-39-28.biz.rr.com ([24.172.39.28]:59142
	"EHLO maunzelectronics.com") by vger.kernel.org with ESMTP
	id <S267268AbSK3QNe>; Sat, 30 Nov 2002 11:13:34 -0500
Message-ID: <3DE8E559.74FD1A1E@justirc.net>
Date: Sat, 30 Nov 2002 11:20:41 -0500
From: Mark Rutherford <mark@justirc.net>
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Sipos Ferenc <sferi@mail.tvnet.hu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: module loading 2.5.50 + nvidia patch
References: <1038665822.1045.3.camel@zeus.city.tvnet.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 1.0.12.3 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try this patch to get the nvidia working. : http://www.minion.de/nvidia.html
you need to patch the source, im afraid there is no patch for binary drivers
:D
keep in mind its very buggy and tents to crash. mainly on exit from X11
hope this helps.


Sipos Ferenc wrote:

> Hi!
>
> I have compiled the kernel with make menuconfig, make bzImage, modules,
> modules_install, and installed rusty's latest compatible modprobe util,
> but moduls won't load, modprobe xx says modprobe.dep not found. With
> insmod, I can load modules, but I'd like that the kernel do it
> automatically such as in 2.4. In kernel config, the neccessary options
> for this are set. What am I missing, or how has the kernel configuration
> changed? By the way, does anybody has a working patch for the binary
> 3123 drivers? Thx.
>
> Paco
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
Regards,
Mark Rutherford
mark@justirc.net


File: Mark Rutherford.ASC
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: PGPfreeware 7.0.3 for non-commercial use <http://www.pgp.com>

mQGiBDqwRnsRBADTpKKSKAcphYdcVTvBpEFFNK1eL4dQ/pBwK4NimeoAA9ISD04L
Mv/CqH5g9D1wzXEhRBhbFZnmfoTPFEWH4Gjr4KIPdsXkTEfoJ2j55qksHWMkE10A
K8gZlI3Ovuf8BbIabfXmjf+XtId3F4+7+og4mc7EAkatYbbl/5pR0Niy3wCg/+I/
LUQPYGloF829jXaOW7C+tG8D/RZt8lAL/Z1NfGsQYZlE1X+Gcqf0J6HaMosnVuah
1zAbgUHCIvNq+TOC+0KydEvbs7tAq6m+Q4zQZaqEsMwufTCWxzh+v3thRBLIuT5E
jsTi4djkrdG3TTeAszymO/YEXQMg4Tq2hMiyeWlyTmH4C6enMu0zJMIu4OEef7+W
KpYhBACYnukDVI8Vnw1J5KaiCZYvERhj4cr3BTk7oeYxIRH1x5S6NXK0+uVcpusa
a8ZU4zcxvHh0k3iR8HIZcNh30eXbMF/J5pW9gorJuPwCC5Q7b+gUVaeec+1X+Wmt
2k8RAq9RtriUdrmVN5QcPBLFd4hOHQcWDcuyhmiFp68LFvxLSLQrTWFyayBSdXRo
ZXJmb3JkIDxNYXJrMjAwMEBiZWxsYXRsYW50aWMubmV0PokAWAQQEQIAGAUCOrBG
ewgLAwkIBwIBCgIZAQUbAwAAAAAKCRAudCWX7QO6ULcaAJwIsYHeAp6FC5OVWSOo
qc8O87kvBgCgz1cLgVXYcSlDWEeE32PFYb6akuy5Ag0EOrBGexAIAPZCV7cIfwgX
cqK61qlC8wXo+VMROU+28W65Szgg2gGnVqMU6Y9AVfPQB8bLQ6mUrfdMZIZJ+AyD
vWXpF9Sh01D49Vlf3HZSTz09jdvOmeFXklnN/biudE/F/Ha8g8VHMGHOfMlm/xX5
u/2RXscBqtNbno2gpXI61Brwv0YAWCvl9Ij9WE5J280gtJ3kkQc2azNsOA1FHQ98
iLMcfFstjvbzySPAQ/ClWxiNjrtVjLhdONM0/XwXV0OjHRhs3jMhLLUq/zzhsSlA
GBGNfISnCnLWhsQDGcgHKXrKlQzZlp+r0ApQmwJG0wg9ZqRdQZ+cfL2JSyIZJrqr
ol7DVekyCzsAAgIIAO5Bt3XOgo2GPNOCuLv6A6mRxPxwwVsYEMmVAIp/c5nluBMi
Tu4iQU5f3U9UqZMcFKyLr1Vh0bpO6RB6L/5tXWSRY2Yly9Ofg/e0Npgebkdd8GXE
+IuEDI4lr1kbO70hlxFUPKSOQRjSmmVKNhUAiXEFQ7OtB9k5GECsHrD6qxR6r/ny
XMBK2g2UUSh17Gx/pqH+XwXJ67DEQmF8hcnyiN9E3WQ5w3bIbKwFCaHF+tJbVnUd
XxszxQYrsb6Feo0FVdCD+VVPQGesv34CrnKuED/mF/WoI8a3eYCMiY03IQgW514X
JX+Jnmk9RFbTg75NdXIKDqKpB3wq39n3JmWRZG+JAEwEGBECAAwFAjqwRnsFGwwA
AAAACgkQLnQll+0DulAfjgCfbVxiUtJbpXPn6gVJlnlIzur1yvgAnjh/9bdLsSrd
cUaN07NL7N9NjgG1
=hpbN
-----END PGP PUBLIC KEY BLOCK-----

