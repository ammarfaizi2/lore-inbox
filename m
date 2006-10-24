Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752076AbWJXFwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbWJXFwn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 01:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbWJXFwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 01:52:43 -0400
Received: from main.gmane.org ([80.91.229.2]:42144 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1752077AbWJXFwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 01:52:42 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH] x86_64 irq: reuse vector for set_xxx_irq_affinity in phys flat mode
Date: Tue, 24 Oct 2006 05:52:33 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnejratd.93p.olecom@flower.upol.cz>
References: <5986589C150B2F49A46483AC44C7BCA412D747@ssvlexmb2.amd.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, Lu.

On 2006-10-23, Lu, Yinghai wrote:
> This is a multi-part message in MIME format.
[]
> ------_=_NextPart_001_01C6F6DD.E040B4D2
> Content-Type: application/octet-stream;
>  name=io_apic_reuse_vector.diff
> Content-Transfer-Encoding: base64
> Content-Description: io_apic_reuse_vector.diff
> Content-Disposition: attachment;
>  filename=io_apic_reuse_vector.diff
>
> LS0tIGFyY2gveDg2XzY0L2tlcm5lbC9pb19hcGljX2VyaWMuYwkyMDA2LTEwLTIzIDExOjU2OjM2
> LjAwMDAwMDAwMCAtMDcwMAorKysgYXJjaC94ODZfNjQva2VybmVsL2lvX2FwaWMuYwkyMDA2LTEw

What's problem with Documentation/SubmittingPatches.6 ? 
,-
|6) No MIME, no links, no compression, no attachments.  Just plain text.
`-

> LTIzIDExOjIyOjMxLjAwMDAwMDAwMCAtMDcwMApAQCAtNjEzLDggKzYxMyw5IEBACiAJICogMHg4
> MCwgYmVjYXVzZSBpbnQgMHg4MCBpcyBobSwga2luZCBvZiBpbXBvcnRhbnRpc2guIDspCiAJICov
[]
____

