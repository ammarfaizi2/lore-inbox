Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264759AbTF0UHY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 16:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbTF0UHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 16:07:24 -0400
Received: from smtp-out.comcast.net ([24.153.64.115]:25719 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264759AbTF0UHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 16:07:23 -0400
Date: Fri, 27 Jun 2003 16:20:32 -0400
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
Subject: Re: PPP Modem connection impossible with 2.5.73-bk2
In-reply-to: <20030627022837.3dca1b09.diegocg@teleline.es>
To: diegocg@teleline.es, Kernel List <linux-kernel@vger.kernel.org>
Reply-to: Matthew Harrell 
	  <mharrell-dated-1057177236.425fdb@bittwiddlers.com>
Message-id: <20030627202032.GA28863@bittwiddlers.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.4i
X-Delivery-Agent: TMDA/0.75 (Ponder)
X-Primary-Address: mharrell@bittwiddlers.com
References: <1056567978.931.8.camel@laurelin>
 <20030626195238.673bcffd.diegocg@teleline.es>
 <20030626164116.1bfbad1e.shemminger@osdl.org>
 <20030627022837.3dca1b09.diegocg@teleline.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've got this exact same problem on 2.5.73-bk5.  Connection gets dropped 
just after a connection.  When I switch back to a previous kernel everything
works fine.  Setup is

        PAP authentication
        56K v.92 modem connection over USB serial connection
        UP kernel on P4 1.8 GHz

Let me know if there's anything else I can check.

-- 
  Matthew Harrell                          Never raise your hand to your 
  Bit Twiddlers, Inc.                       children - it leaves your
  mharrell@bittwiddlers.com                 midsection unprotected.
