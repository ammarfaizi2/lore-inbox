Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292482AbSCVHeu>; Fri, 22 Mar 2002 02:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292702AbSCVHek>; Fri, 22 Mar 2002 02:34:40 -0500
Received: from ns.suse.de ([213.95.15.193]:13582 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292482AbSCVHed>;
	Fri, 22 Mar 2002 02:34:33 -0500
Date: Fri, 22 Mar 2002 08:34:23 +0100
From: Dave Jones <davej@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Stephen Williams <mrsteve@midsouth.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.19pre3-ac5
Message-ID: <20020322083423.K22861@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Andre Hedrick <andre@linux-ide.org>,
	Stephen Williams <mrsteve@midsouth.rr.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1016734453.1017.11.camel@swilliam.home.net> <Pine.LNX.4.10.10203212115360.4958-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 09:23:36PM -0800, Andre Hedrick wrote:
 > if (HWGROUP(drive)->handler != NULL)
 > Edit and change it from "==" to "!="

What's wrong with this picture 8-)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
