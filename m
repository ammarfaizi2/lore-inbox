Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288374AbSAHVSq>; Tue, 8 Jan 2002 16:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288372AbSAHVSh>; Tue, 8 Jan 2002 16:18:37 -0500
Received: from ppp-RAS1-4-2.dialup.eol.ca ([64.56.227.2]:3333 "EHLO
	node0.opengeometry.ca") by vger.kernel.org with ESMTP
	id <S288364AbSAHVST>; Tue, 8 Jan 2002 16:18:19 -0500
Date: Tue, 8 Jan 2002 16:18:19 -0500
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: Two hdds on one channel - why so slow?
Message-ID: <20020108161819.A1878@node0.opengeometry.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200201041740.LAA07840@tomcat.admin.navo.hpc.mil> <200201082029.g08KTAA28497@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201082029.g08KTAA28497@snark.thyrsus.com>; from landley@trommello.org on Tue, Jan 08, 2002 at 07:41:42AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 07:41:42AM -0500, Rob Landley wrote:
> The goal was to see how cheaply we could get to 10 terabytes of storage.  We 
> didn't do the whole cluster, but I think we determined we only needed 4 or 5 
> nodes to do it.  Then the dot-com crash hit and that company's business model 
> changed, project got shelved...

Hi Rob, how did you manage to get 10TB storage?  It's my understanding
that kernel block device still counts 1kB blocks using 32bit (signed)
integer.  So, that's 2TB in total.  Are you talking about 5 x 2TB?

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>.
8 CPU cluster, NAS, (Slackware) Linux, Python, LaTeX, Vim, Mutt, Tin
