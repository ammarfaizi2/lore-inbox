Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291547AbSCSTOz>; Tue, 19 Mar 2002 14:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291620AbSCSTOp>; Tue, 19 Mar 2002 14:14:45 -0500
Received: from ns.suse.de ([213.95.15.193]:19726 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291547AbSCSTO2>;
	Tue, 19 Mar 2002 14:14:28 -0500
Date: Tue, 19 Mar 2002 20:14:27 +0100
From: Dave Jones <davej@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zlib double-free bug
Message-ID: <20020319201427.K19346@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <15510.25987.233438.112897@argo.ozlabs.ibm.com> <Pine.LNX.4.44.0203191044150.26226-100000@passion.cambridge.redhat.com> <a77umb$t3s$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > For the record - it's not worth bothering with fs/jffs2/zlib.c; if they 
 > > can corrupt your file system on the medium, why bother with cracking zlib? 
 > Removable media?

 If attacker has physical access to the media, there are far simpler
 ways of corrupting it than zlib exploitation. 8-)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
