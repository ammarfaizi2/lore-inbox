Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbUANUeg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 15:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264557AbUANUef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 15:34:35 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:40569 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S264546AbUANUed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 15:34:33 -0500
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Greg KH <greg@kroah.com>, Nuno Silva <nuno.silva@vgertech.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 013 release
References: <20040113235213.GA7659@kroah.com> <4004D084.1050106@vgertech.com>
	<20040114171527.GB5472@kroah.com>
	<40058086.5000106@nortelnetworks.com>
From: Clay Haapala <chaapala@cisco.com>
Organization: Cisco Systems, Inc. SRBU
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAHlBMVEXl5ufMrp3a4OLr6ujO
 lXzChGmsblZzRzjF1+ErFRAz+KIaAAACVElEQVR4nG3TQW/aMBQAYC9IO88dguyWUomqt0DQ
 do7koO22SXFQb6uE7XIMKrFya+mhPk8D43+79+wMyrp3gnx59nvxMxmNEnIWycgH+U9E55CO
 rkZJ8hYipbXTdfcvQK/Xy6JF2zqI+qpbjZAszSDG2oXYp0FI5mOqbAeuDtLBdeuO8fNVxkzr
 E9jklKEgQWsppYYf9v4IE3i/4RiVRPneQTpoXSM8QA7un3QZQ2cl54wXIH7VDwEmrdOiZBgF
 V5BiLwLM4B3BS0ZpB24d4IvzW+QIc7/JIcAQIadF2eeUzn3FAa6xWFYUotjIRmLB7vEvCC4t
 VAugpTrC2FleLBm2wVnlAc7Dl2u5L1UozgWCjTxMW+vb4GVVFhWWFSCdKmgDMhaNFoxL3bSH
 rc/Irn1/RcWlh+UqNgHeNwishJ1L6LCpjdmGz76RmFGyuSwLgLUxJhyUlLA7fHMpeSGVPsFA
 wqtK4voI8RE+I3DsDpfamSNMpIBTKrF1yIpPMA0AzQPU5gSwCTyC/aEAtX4NM6gLM3CCziBT
 jRR+StQ/AA8a7AMuwxn0YAmcRKnVGwDRiOcw3uMWlajgAJsAPbw4OIpwrH3/vdq9B7hpl7GD
 w61A4PxwSqyH9J25gePnYdqhYjjZ5s6QCb3bwvOLJWPBFvCvWVDSthYmcff44IcacOUOt1Yv
 yGCF1+twuQtQCPjzZIaK/Lrx9+6b7TKEdXTwgz8R+uJv5K1jOcWMnO7NJ3v/QlprnzP1deUe
 8j4CpVE82MRj4j5SHGDnfvul8uGwjqNnpf4Ak4pzJDIy3lkAAAAASUVORK5CYII=
Date: Wed, 14 Jan 2004 14:34:26 -0600
In-Reply-To: <40058086.5000106@nortelnetworks.com> (Chris Friesen's message
 of "Wed, 14 Jan 2004 12:46:46 -0500")
Message-ID: <yqujn08q46ct.fsf@chaapala-lnx2.cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.5 (celeriac, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jan 2004, Chris Friesen spake thusly:
> 
> Maybe for ones with a matching rule, you could print something like:
> 
> 
Is the act of printing/syslogging a rule in an of itself? 
-- 
Clay Haapala (chaapala@cisco.com) Cisco Systems SRBU +1 763-398-1056
   6450 Wedgwood Rd, Suite 130 Maple Grove MN 55311 PGP: C89240AD
	   "Too bad marketing doesn't run on my computer."
			-- acousticiris, on /.
