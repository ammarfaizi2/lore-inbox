Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbWD1K6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbWD1K6L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 06:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbWD1K6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 06:58:11 -0400
Received: from wproxy.gmail.com ([64.233.184.233]:41137 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965000AbWD1K6J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 06:58:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jq3Yb1gJbzQ6HFRs2rsGd7ajAYfOURcWlSoRQmO2A0i2Ov00OFmhyuL0uYxtl6E6yQDUXwosA3K3LoelZtQNWuk5LBYZvexcluZOqm+mkLTc2hiZp0/k3hutWEoZLO0Wuwz4OVQHDWvV9Zg7Krg0eQr3aLhAUc1u7geRRPUcTqU=
Message-ID: <84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com>
Date: Fri, 28 Apr 2006 13:58:04 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "David Vrabel" <dvrabel@cantab.net>,
       "Francois Romieu" <romieu@fr.zoreil.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: IP1000 gigabit nic driver
In-Reply-To: <20060428075725.GA18957@fargo>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20060427142939.GA31473@fargo>
	 <20060427185627.GA30871@electric-eye.fr.zoreil.com>
	 <445144FF.4070703@cantab.net> <20060428075725.GA18957@fargo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/06, David Gómez <david@pleyades.net> wrote:
> I could help. What things do you think need to be fixed before
> submitting the driver?

Needs some serious coding style cleanup and conversion to proper 2.6
APIs for starters.
