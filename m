Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312832AbSCZXaa>; Tue, 26 Mar 2002 18:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312836AbSCZXaV>; Tue, 26 Mar 2002 18:30:21 -0500
Received: from ns.suse.de ([213.95.15.193]:23047 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312832AbSCZXaG>;
	Tue, 26 Mar 2002 18:30:06 -0500
Date: Wed, 27 Mar 2002 00:30:00 +0100
From: Dave Jones <davej@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: greearb@candelatech.com, linux-kernel@vger.kernel.org
Subject: Re: up-to-date bk repository?
Message-ID: <20020327003000.C7501@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"David S. Miller" <davem@redhat.com>, greearb@candelatech.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <3CA0FEF7.90003@candelatech.com> <20020326.151104.118632068.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2002 at 03:11:04PM -0800, David S. Miller wrote:
 > 
 > echo -n >include/asm-i386/proc_fs.h

*blink* asm specific proc_fs stuff ?

s/asm/linux/ in the #include surely ?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
