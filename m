Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318027AbSIJTCm>; Tue, 10 Sep 2002 15:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318035AbSIJTCm>; Tue, 10 Sep 2002 15:02:42 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:54802 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318027AbSIJTCm>;
	Tue, 10 Sep 2002 15:02:42 -0400
Date: Tue, 10 Sep 2002 12:04:24 -0700
From: Greg KH <greg@kroah.com>
To: Bob_Tracy <rct@gherkin.frus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.X config: USB speedtouch driver
Message-ID: <20020910190424.GA22753@kroah.com>
References: <m17oq8v-0005khC@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17oq8v-0005khC@gherkin.frus.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 01:53:45PM -0500, Bob_Tracy wrote:
> Minor nit: the subject driver depends on ATM, so a config-time check to
> see if ATM support is enabled is appropriate.

Agreed, patch? :)

greg k-h
