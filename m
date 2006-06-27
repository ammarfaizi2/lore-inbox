Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932585AbWF0XJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbWF0XJJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 19:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbWF0XJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 19:09:09 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:17536 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932585AbWF0XJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 19:09:07 -0400
Subject: RE: [PATCH] ia64: change usermode HZ to 250
From: Lee Revell <rlrevell@joe-job.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: hawkes@sgi.com, Tony Luck <tony.luck@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jack Steiner <steiner@sgi.com>,
       Dan Higgins <djh@sgi.com>, Jeremy Higdon <jeremy@sgi.com>
In-Reply-To: <617E1C2C70743745A92448908E030B2A27F855@scsmsx411.amr.corp.intel.com>
References: <617E1C2C70743745A92448908E030B2A27F855@scsmsx411.amr.corp.intel.com>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 19:09:06 -0400
Message-Id: <1151449747.2899.145.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 15:26 -0700, Luck, Tony wrote:
> > -# define HZ 1024
> > +# define HZ 250
> 
> Is every distribution just using the default 250? (How boring,
> what't the use of CONFIG options if everyone makes the same choice).
> 

No.  Multimedia oriented distros use 1000.

Lee

