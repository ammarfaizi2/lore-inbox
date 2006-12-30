Return-Path: <linux-kernel-owner+w=401wt.eu-S1030349AbWL3VdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbWL3VdF (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 16:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbWL3VdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 16:33:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:40520 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030350AbWL3VdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 16:33:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FPtOi41f7mUjDTfQhMkjhUvFQB48+KygBtuJl7hUu/+EACoqJyz2wJNDZ+ERrMfr2DpPKs9PWFrIsLkL3PxBjNYVIofhU3RMrSMVMUwsErl/QN/te3mgsYxhpTpw7ZBMsqRtCd1678ua4nkowT1u87Uf2g/dAy1wMAEInA59/DI=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFC,PATCHSET] Managed device resources
Date: Sat, 30 Dec 2006 22:31:48 +0100
User-Agent: KMail/1.8.2
Cc: gregkh@suse.de, jeff@garzik.org, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
References: <1167146313307-git-send-email-htejun@gmail.com>
In-Reply-To: <1167146313307-git-send-email-htejun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612302231.48510.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 December 2006 16:18, Tejun Heo wrote:
> Hello, all.
> 
> This patchset implements managed device resources, in short, devres.

I was working on a Linux device driver. Indeed, those error paths
are notoriously prone to bugs.

Patchset looks like good idea to me.
--
vda
