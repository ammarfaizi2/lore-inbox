Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261278AbTCNXXE>; Fri, 14 Mar 2003 18:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261281AbTCNXXE>; Fri, 14 Mar 2003 18:23:04 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:24846 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261278AbTCNXXE>;
	Fri, 14 Mar 2003 18:23:04 -0500
Date: Fri, 14 Mar 2003 15:22:34 -0800
From: Greg KH <greg@kroah.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.64 ttyS problem ?
Message-ID: <20030314232234.GC8734@kroah.com>
References: <200303140937.04049.pbadari@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303140937.04049.pbadari@us.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 09:37:04AM -0800, Badari Pulavarty wrote:
> Hi,
> 
> Any one see this problem ? Is it a known problem ?

Pat Mochel reported this problem in the past.  I think it might be fixed
in the latest -bk tree, have you tried that?

thanks,

greg k-h
