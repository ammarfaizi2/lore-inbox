Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270600AbTGNMuM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270603AbTGNMh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:37:59 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:61121
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270597AbTGNM1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:27:36 -0400
Subject: Re: Linux v2.6.0-test1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, John Bradford <john@grabjohn.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <20030714120009.GH15452@holomorphy.com>
References: <200307141150.h6EBoe1P000738@81-2-122-30.bradfords.org.uk>
	 <20030714115313.GA21773@suse.de>  <20030714120009.GH15452@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058186383.606.52.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jul 2003 13:39:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-14 at 13:00, William Lee Irwin III wrote:
> Some work has been done here, though I'm not sure how much; I'll try to
> get the IBM people involved with it to chime in.

The IBM india folks (being outside the DMCA zone) went through a long list of 
fixes and propogated them but there are lots of others some pretty critical such
as the fs/exec stuff and proc leaks

