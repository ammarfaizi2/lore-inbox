Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTDQRNO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 13:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbTDQRNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 13:13:14 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37832
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261808AbTDQRNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 13:13:12 -0400
Subject: Re: Help with virus/hackers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: root@chaos.analogic.com, joe briggs <jbriggs@briggsmedia.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <200304171545.h3HFjPoH000129@81-2-122-30.bradfords.org.uk>
References: <200304171545.h3HFjPoH000129@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050596810.31414.103.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Apr 2003 17:26:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-04-17 at 16:45, John Bradford wrote:
> I've often wondered whether it would be worth connecting a very large
> serial EEPROM to a serial port interface, and have it effectively
> appear as a solid state printer, (to that you could cheaply log to an
> unmodifyable device).  Has anybody ever tried this?

Linux supports console on printer. Its not totally foolproof (there is
a famous story of someone who simply reprinted the past two days of logs
edited so the admins wouldnt realise when they looked) but it works pretty
well. Just use a dot-matrix printer save keeping HP, Lexmark or Xerox in
business 8)

