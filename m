Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292765AbSCEOay>; Tue, 5 Mar 2002 09:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293162AbSCEOao>; Tue, 5 Mar 2002 09:30:44 -0500
Received: from brev.stud.ntnu.no ([129.241.56.70]:10114 "EHLO
	brev.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S292765AbSCEOa1>; Tue, 5 Mar 2002 09:30:27 -0500
Date: Tue, 5 Mar 2002 15:30:25 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        linux-net@vger.kernel.org
Subject: Re: [BETA-0.95] Sixth test release of Tigon3 driver
Message-ID: <20020305153025.A12473@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020305.055204.44939648.davem@redhat.com> <20020305150204.A7174@stud.ntnu.no> <20020305.060323.99455532.davem@redhat.com> <20020305.060604.68157839.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020305.060604.68157839.davem@redhat.com>; from davem@redhat.com on Tue, Mar 05, 2002 at 06:06:04AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller:
> Most gigabit switches don't support 9000 byte mtu :-)

Hmm, I found a document through google; Cisco Catalyst 4006 doesn't support
9KB MTUs, so I'll contact the networking guys and fix this, we want switches
that supports large MTUs :)

-- 
Thomas
