Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWHQI0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWHQI0U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 04:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWHQI0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 04:26:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:32191 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932175AbWHQI0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 04:26:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=WIzF+bynblMmSxkS4SY0VEeOdhZqjUqAaW9FgHtIQIe3KIx7wKempoLFwPTGwk2S0hfOe3mwoIJDFk4tcCL9MmYrauXcgg4n4Y0IBL26uTpU+OF9qEhAFRGFXlwmDNkJdL64eIPPQm+X8A3MFQkq3A+hz0YXzgZPPzP5nX5j4XA=
Message-ID: <84144f020608170126n37574012u1dd6756ea6ead061@mail.gmail.com>
Date: Thu, 17 Aug 2006 11:26:16 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Jesse Huang" <jesse@icplus.com.tw>
Subject: Re: [PATCH 1/7] ip1000: update maintainer information
Cc: romieu@fr.zoreil.com, akpm@osdl.org, dvrabel@cantab.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       david@pleyades.net
In-Reply-To: <1155843743.5006.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1155843743.5006.3.camel@localhost.localdomain>
X-Google-Sender-Auth: e6f73cf5786dcbba
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesse,

On 8/17/06, Jesse Huang <jesse@icplus.com.tw> wrote:
> From: Jesse Huang <jesse@icplus.com.tw>
>
> update maintainer information
>
> Change Logs:
>     update maintainer information

The patches are missing signed-off-by so please resend. I am starting
my vacation on friday so I suggest you send the whole driver as a
patch for review at netdev@vger.kernel.org for inclusion. I can apply
your patches to
git://git.kernel.org/pub/scm/linux/kernel/git/penberg/netdev-ipg-2.6.git
if you want, though. Only the first three patches apply and everything
starting from "ipg_config_autoneg rewrite' fail.

                                              Pekka
