Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262655AbVFWSNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbVFWSNM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 14:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVFWSNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 14:13:12 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:14517 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S262659AbVFWSKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 14:10:04 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: guorke <gourke@gmail.com>
Subject: Re: 2.6.12 can not support via rhine?
Date: Thu, 23 Jun 2005 12:09:56 -0600
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <d73ab4d005062221176e77a960@mail.gmail.com>
In-Reply-To: <d73ab4d005062221176e77a960@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506231209.56692.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 June 2005 10:17 pm, guorke wrote:
> when i reboot use 2.6.11,it's ok.
> but when i use 2.6.12 kernel, i get this:
> 
> via rhine device dose not seem to be present , delaying eth0 initialzation..
> but in 2.6.11, it's say ok, I must say i have add via rhine support.

Are you sure your 2.6.12 .config has CONFIG_VIA_RHINE set?

Could you post the complete 2.6.11 and 2.6.12 dmesg logs?  I couldn't
quite follow the excerpts your posted.
