Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292554AbSCSUJs>; Tue, 19 Mar 2002 15:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292555AbSCSUJi>; Tue, 19 Mar 2002 15:09:38 -0500
Received: from ns.suse.de ([213.95.15.193]:14853 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292554AbSCSUJS>;
	Tue, 19 Mar 2002 15:09:18 -0500
Date: Tue, 19 Mar 2002 21:09:16 +0100
From: Dave Jones <davej@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zlib double-free bug
Message-ID: <20020319210916.M19346@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <15510.25987.233438.112897@argo.ozlabs.ibm.com> <Pine.LNX.4.44.0203191044150.26226-100000@passion.cambridge.redhat.com> <a77umb$t3s$1@cesium.transmeta.com> <20020319201427.K19346@suse.de> <3C979333.6020500@zytor.com> <20020319205029.L19346@suse.de> <3C97988B.1030401@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 11:59:07AM -0800, H. Peter Anvin wrote:

 > >  My understanding from one of dwmw2's earlier posts was that jffs2
 > >  has crc's that would prevent this happening anyway (or at least make
 > >  it nigh on impossible)
 > I doubt that.  We're talking about corrupting the kernel VM.

 Ignore me, I'm losing my mind.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
