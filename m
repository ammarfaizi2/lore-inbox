Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287565AbSBUHlK>; Thu, 21 Feb 2002 02:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287769AbSBUHlA>; Thu, 21 Feb 2002 02:41:00 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:4318 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S287283AbSBUHku>; Thu, 21 Feb 2002 02:40:50 -0500
From: Christoph Rohland <cr@sap.com>
To: "Peter J. Braam" <braam@clusterfs.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, phil@off.net
Subject: Re: tmpfs, NFS, file handles
In-Reply-To: <20020220094649.X25738@lustre.cfs>
	<3C73D548.648C5D64@mandrakesoft.com>
	<20020220122116.C28913@lustre.cfs>
Organisation: SAP LinuxLab
Date: Thu, 21 Feb 2002 08:40:21 +0100
In-Reply-To: <20020220122116.C28913@lustre.cfs> ("Peter J. Braam"'s message
 of "Wed, 20 Feb 2002 12:21:16 -0700")
Message-ID: <m38z9ns2oq.fsf@linux.wdf.sap-ag.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, 20 Feb 2002, Peter J. Braam wrote:
> Between boot cycles NFS could still get confused, that might be
> helped by setting the initial generation to the system time.

Between boot cycles you loose _all_ tmpfs files. That's what the
'tmp' in tmpfs talks about ;-)

Greetings
		Christoph


