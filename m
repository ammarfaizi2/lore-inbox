Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbUCEEmt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 23:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbUCEEmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 23:42:49 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:30983 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id S262211AbUCEEmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 23:42:47 -0500
From: Stuart Young <sgy-lkml@amc.com.au>
Organization: AMC Enterprises P/L
To: David Ford <david+challenge-response@blue-labs.org>
Subject: Re: ACPI battery info failure after some period of time, 2.6.3-x and up
Date: Fri, 5 Mar 2004 15:43:04 +1100
User-Agent: KMail/1.5.4
Cc: jason@stdbev.com, linux-kernel@vger.kernel.org
References: <4047756D.2050402@blue-labs.org> <200403051520.40341.sgy-lkml@amc.com.au> <4048015D.6070308@blue-labs.org>
In-Reply-To: <4048015D.6070308@blue-labs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403051543.04300.sgy-lkml@amc.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2004 03:26 pm, David Ford wrote:
> run a watch -n 1 'cat /proc.../status' and it'll happen really quick, on
> my machine it happens inside 15 minutes.  my notebook is a dell inpsiron
> 8200.

Tried it as soon as you sent me a reply using:
 watch -n 1 'cat /proc/acpi/battery/BAT0/state'

...and it just failed then, using 2.6.4-rc2 still.

--
 Stuart Young - sgy-lkml@amc.com.au is for LKML and related email only

