Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263221AbVFXUsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbVFXUsm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 16:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263213AbVFXUnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 16:43:45 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:34359 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263215AbVFXUmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 16:42:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fBH2zEh7j7iC/UiviUsQLDIUs/6n9EWRZ8FCi9siNwFmLTgzURFixxBZrtUhjaPQypO3WY4yMK4C3XGMz8IKL09xUYZtCSX/LbqTcOoQO3yF1o1XOhpX1nthgPFSyRfdk+630XySX2M8kIj3Pq6yltK0K0DyM5wR9fPHS6lHGI0=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Alexander Y. Fomichev" <gluk@php4.ru>
Subject: Re: 2.6.12 hangs on boot
Date: Sat, 25 Jun 2005 00:47:51 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, admin@list.net.ru
References: <200506221813.50385.gluk@php4.ru>
In-Reply-To: <200506221813.50385.gluk@php4.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506250047.53204.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 June 2005 18:13, Alexander Y. Fomichev wrote:
> I've been trying to switch from 2.6.12-rc3 to 2.6.12 on Dual EM64T 2.8 GHz
> [ MoBo: Intel E7520, intel 82801 ]
> but kernel hangs on boot right after records:
> 
> Booting processor 2/1 rip 6000 rsp ffff8100023dbf58
> Initializing CPU#2

I've filed a bug at kernel bugzilla, so your report won't be lost.
See http://bugme.osdl.org/show_bug.cgi?id=4792

You can register at http://bugme.osdl.org/createaccount.cgi and add yourself
to CC list.
