Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269029AbUHaVJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269029AbUHaVJL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269190AbUHaVIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 17:08:06 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:22774 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S269029AbUHaVDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 17:03:36 -0400
Date: Tue, 31 Aug 2004 23:03:27 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: irda-users@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, dag@brattli.net
Subject: [2.6 patch] update Dag Brattli's email address
Message-ID: <20040831210327.GU3466@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch (attached gzip'ed due to it's size) updates the email address 
of Dag Brattli in kernel 2.6 to his current address.

It was already ACK'ed by Dag Brattli.

diffstat output:
 drivers/net/irda/actisys-sir.c        |    4 ++--
 drivers/net/irda/actisys.c            |    6 +++---
 drivers/net/irda/esi-sir.c            |    6 +++---
 drivers/net/irda/esi.c                |    8 ++++----
 drivers/net/irda/girbil-sir.c         |    6 +++---
 drivers/net/irda/girbil.c             |    6 +++---
 drivers/net/irda/irport.c             |    6 +++---
 drivers/net/irda/irport.h             |    6 +++---
 drivers/net/irda/irtty-sir.c          |    4 ++--
 drivers/net/irda/litelink-sir.c       |    6 +++---
 drivers/net/irda/litelink.c           |    6 +++---
 drivers/net/irda/mcp2120-sir.c        |    2 +-
 drivers/net/irda/mcp2120.c            |    2 +-
 drivers/net/irda/nsc-ircc.c           |    8 ++++----
 drivers/net/irda/nsc-ircc.h           |    6 +++---
 drivers/net/irda/old_belkin-sir.c     |    2 +-
 drivers/net/irda/old_belkin.c         |    2 +-
 drivers/net/irda/smsc-ircc2.h         |    2 +-
 drivers/net/irda/tekram-sir.c         |    4 ++--
 drivers/net/irda/tekram.c             |    6 +++---
 drivers/net/irda/w83977af_ir.c        |    6 +++---
 drivers/net/irda/w83977af_ir.h        |    2 +-
 drivers/net/wireless/netwave_cs.c     |    6 +++---
 drivers/usb/serial/ir-usb.c           |    2 +-
 include/linux/irda.h                  |    4 ++--
 include/net/irda/af_irda.h            |    4 ++--
 include/net/irda/crc.h                |    4 ++--
 include/net/irda/discovery.h          |    4 ++--
 include/net/irda/ircomm_core.h        |    4 ++--
 include/net/irda/ircomm_event.h       |    4 ++--
 include/net/irda/ircomm_lmp.h         |    4 ++--
 include/net/irda/ircomm_param.h       |    4 ++--
 include/net/irda/ircomm_ttp.h         |    4 ++--
 include/net/irda/ircomm_tty.h         |    4 ++--
 include/net/irda/ircomm_tty_attach.h  |    4 ++--
 include/net/irda/irda.h               |    4 ++--
 include/net/irda/irda_device.h        |    4 ++--
 include/net/irda/iriap.h              |    6 +++---
 include/net/irda/iriap_event.h        |    6 +++---
 include/net/irda/irias_object.h       |    4 ++--
 include/net/irda/irlan_client.h       |    6 +++---
 include/net/irda/irlan_common.h       |    6 +++---
 include/net/irda/irlan_eth.h          |    4 ++--
 include/net/irda/irlan_event.h        |    6 +++---
 include/net/irda/irlan_filter.h       |    4 ++--
 include/net/irda/irlan_provider.h     |    6 +++---
 include/net/irda/irlap.h              |    6 +++---
 include/net/irda/irlap_event.h        |    6 +++---
 include/net/irda/irlap_frame.h        |    6 +++---
 include/net/irda/irlmp.h              |    6 +++---
 include/net/irda/irlmp_event.h        |    6 +++---
 include/net/irda/irlmp_frame.h        |    6 +++---
 include/net/irda/irmod.h              |    4 ++--
 include/net/irda/irqueue.h            |    4 ++--
 include/net/irda/irttp.h              |    6 +++---
 include/net/irda/parameters.h         |    4 ++--
 include/net/irda/qos.h                |    4 ++--
 include/net/irda/timer.h              |    6 +++---
 include/net/irda/wrapper.h            |    6 +++---
 net/irda/af_irda.c                    |    4 ++--
 net/irda/discovery.c                  |    4 ++--
 net/irda/ircomm/ircomm_core.c         |    4 ++--
 net/irda/ircomm/ircomm_event.c        |    4 ++--
 net/irda/ircomm/ircomm_lmp.c          |    4 ++--
 net/irda/ircomm/ircomm_param.c        |    4 ++--
 net/irda/ircomm/ircomm_ttp.c          |    4 ++--
 net/irda/ircomm/ircomm_tty.c          |    6 +++---
 net/irda/ircomm/ircomm_tty_attach.c   |    4 ++--
 net/irda/ircomm/ircomm_tty_ioctl.c    |    4 ++--
 net/irda/irda_device.c                |    4 ++--
 net/irda/iriap.c                      |    6 +++---
 net/irda/iriap_event.c                |    6 +++---
 net/irda/irias_object.c               |    4 ++--
 net/irda/irlan/irlan_client.c         |    6 +++---
 net/irda/irlan/irlan_client_event.c   |    6 +++---
 net/irda/irlan/irlan_common.c         |    8 ++++----
 net/irda/irlan/irlan_eth.c            |    4 ++--
 net/irda/irlan/irlan_event.c          |    4 ++--
 net/irda/irlan/irlan_filter.c         |    4 ++--
 net/irda/irlan/irlan_provider.c       |    6 +++---
 net/irda/irlan/irlan_provider_event.c |    6 +++---
 net/irda/irlap.c                      |    4 ++--
 net/irda/irlap_frame.c                |    6 +++---
 net/irda/irlmp.c                      |    6 +++---
 net/irda/irlmp_event.c                |    6 +++---
 net/irda/irlmp_frame.c                |    6 +++---
 net/irda/irmod.c                      |    6 +++---
 net/irda/irproc.c                     |    4 ++--
 net/irda/irqueue.c                    |    4 ++--
 net/irda/irsysctl.c                   |    4 ++--
 net/irda/irttp.c                      |    6 +++---
 net/irda/parameters.c                 |    4 ++--
 net/irda/qos.c                        |    6 +++---
 net/irda/timer.c                      |    6 +++---
 net/irda/wrapper.c                    |    6 +++---
 CREDITS                               |    6 +-----
 96 files changed, 233 insertions(+), 237 deletions(-)


--Nq2Wo0NMKNjxTN9z
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="patch-email-Dag-3.gz"
Content-Transfer-Encoding: base64

H4sICPDmNEECA3BhdGNoLWVtYWlsLURhZy0zAOxdaXPaypr+bP+KnkzVjH1isFYW3VTGBDsJ
Obbja8hJnflCyVIDioXE0eLlVN353ffjvG9LgEASmxG7qxJho+7W8rz70nWjbVE9Z7dauYdX
hVR0x1At8sm3HsmHB/j/ouXmPb+b1+nH4+NcLkdMw/JfckK+kC/nHI3PdbtCruWb5nn1/uqy
1qjnbVM/EjhOynGlnMgTQVBkWZHFPNf/Ie85+P74/fv3Uycbn6igyMXYRBcXJCdJ5TNeIO/x
WCIXF8ekrpAf9coxOSa3CrlU2+STo3qeaRznrhSiq+2HC83N+4aXt+zj3E+FdDyvp5yfPz8/
5wdfnP8fnnj8Phhx8RDMkLeod0wuFVJzLiuk7j+4r65Hu8c5WJIv58lPasJ9tT3bIve2qrO/
X6uWpsJZzhm5rvBEurxlf/7x+xm5stqmaunhlV6rjguXaliPHXgnxwSWNuFPF5atOfQ5bzvt
lLfABw8O3t8Tddxz3304dym8TPPccHLwW14bfTMcEUSF5xRRmPHNTF9gfHJeEQrJb4s7K8K7
wv/xVZHfjiq6TnXi+r2e7XikZTukazs0eMI/6p+ITp8Mjbr5lJP/po5Neqr2SL08IcH3D36r
RR1iw9U6hk7ha0ftquwVuDabx4frd4kGePcc1XLxbHjWbTgEU7lE9YhtaZQYLeJ16Ct5NtwO
LPDJ9jpwjqd1qHucg5k0tUtJy7G7UaSRDwga+4G+aLZO85rd/Zg/fj/57AjEPrKbxX8Enhvf
/K55Ta541HZomzx22A0YluHBCyD4QgyAm0NNqrpUz8+GEVgE3p2uwn+e95pzDWfZIElaYXx2
UeFSUMJAMsAI+SO4S4UEP3BJ7M+X1NUco+eFXzHIwIVRohuuZvTYR6PbM2mXWp6Kp7Fhdfjs
u/3JyNVLD8DMTjHz+E5Jxfc6tjM4YfxVRfjHR3yr084febXsCqoOBTjqADI2qOFTuBeNkDIR
eIUvKWIJ2Em5yM69sXWjZQxOrvsWATwQoYhsER4hPkuOE0bPRYZOyI3qeIZFLg3aMcmHrqpf
dHX8zFg6PueCJOCTDg74rLu27pu0ieg6YS+uCS+O/Xr6j8G39GXkWw2QZ/k9POE4d/P98sf1
VbPyo/H1+/3Ju0mP7h2MeD/l/JFHhwNIOODyql69r901at9vT96xF99o/BnyChJgMHp65bpW
qTevL2v16slts3Z/WYl8eV2rXt3Wr07efbm7xkHzUZDlajnD0bTMCGi4QFQmcpzCy0mTB/TD
JCL+n0xBfDIFXbK1GV8Fpkdu61VyV/1vnisREFP4UQRksqetdYyeC3wyiaDg1weTroeU6sC3
b+0nQopIShK8ARlJqZRESj/hE5AIPA2CAqusiBKSEscufIyUpl74lPPjF85WwZ+q3Xt1jHbH
IyfaKbvYHF7F9CXnGRxfP3k0uTZAtFnkp2q1z8gH8xmOF6rmGaDpMDk2aWwlOA++cnr5M4IK
VWToYGTFNMk9jnTJPQVB/ER1hloBrhzZUXhE5B451PMdi3BArf9aG39BOmCovwz4y2WMv4yz
EDInE2kbzoNhZsZC+tPHBbAspTEQjjEQLpWBCIkieETaDhjJF4dS6xmQRb7UnE+1a6LboPrS
zZTGyEI+0wdCCshCOEERRYR3OYmFfHYMJrn5IuHK+DwFLjh3NSwklRbL0dFnSRSXHwwmIfFJ
Ae1JY6QHh7USXwp2EoR8jAijwv/kHVJCLhick+B7cv4bQU2g+aV2D/M2L7/ffrm+Ir+dz0m7
zyWxXCyqrSaouJ2MCHhkjfH5JYUTE6m4iG+0OFSjxyjjTvVN8gdIdurUe/QxUTPt+Eyc8mWC
zEJGEZkmTlGL/QYWFc/juVxJgUErFKdkdok4lSDmA4BpeBTOfszUjBpdJA4BvrwoI+dn0ATv
wII2TfUF1AOPXsNlTODggfq3FtaN7PhGfUXtjxcUmZuDdUuKIG4d62avmC8xOg8Om6M0jUDG
HEJmyLiPFuHccpRzX9caV9e1298X5t0efXTUbqaEG10iTrapBtxEBwifF2fQvmzmuiINdgGg
wN4AqcBzywk892mjNTA0zJiPgwcBwjSwdCNu1B+C55YW94ekKkHrJaVJb/BtehAXpabG1e/3
lZul6EHaCvSgBGqSuRQ9qIx6UHlxPQgRydwKEroKpILCF1IRiYIF9SChhEII7lou771bIccE
2z19oOaIK2AoBxsdwyU9x24j0uFjC9R+4tot71l16D/Iq+0zd71DdcP1HOPBB0owPPRLnYOO
EghCUWb+g/AYpd//cqnZyn10gdO5ayXln4b1YFs6+cmAXPm8Er9CpvItusT49LLCHfwLW+tf
WKKOKkhlJljZIUqYJzo1QWH/SLhT8j8k+EU5+BymER11jcwIms0dp2RBXjTUIM9gYF69eNTC
2G2dRdRd8o16V69geFa3gpZBU+VLiiyFkbvSTAYnJ63S4MzNSMzjy52lKwUJI0cWPpsULGh0
7K7qwgxPhgtjYdgDdbwLR9WNR3ds+AxGsFBgop8dNkdznwrrt7EUPspSruq1hfmJ2w2DjEJm
LszoEnHuIiZ7MPlAoRumi7C3/gkzHQjIf7cbhkY7yjSQM/31bEHtN230XOrv2QjkyYmn6vjh
4lfPHR2fFB/DW1/EtZGxWyNJUKQYYUtS+fbCqRFT+7jyRvgmQztu7tiSzDyUwWGTYkvb4Vjp
u/4zjy3EqbmQnqF1iCvselwhoFpePsQV5ibZQc5WJ+uksE6cZIXiYpZaEr1upixFGmNhaSAt
sLmKisRNDBAwdyycCycWFY47ZHmtKctrPiIKZ83UezmyRpyUpGT3pYyMUR6G52bzUlaqDaP+
Z53pGQJ3zXIqw8/vh4w78hOwpsQcy0/UU6O0N/hmEp7ISZg2br6eRugwdewInEYGYwr6EQFr
FgirYfuOY5gd6pIPv7yLTs/Md3oMReTEos/9FPXBoElRuJER7MFhhrFOn07nUqmZ0ikyj0Bw
eKv4Irlp9zq3gJttykQROBFIS5GGQlQawnI1WG5hYWg4WK2RmSjsTz8+dRGUr8UEIZesu9ZZ
zUv4ZBk4MXizoY5JkHoVv02IiMlYUhmDkGklBf2AJS8ReB9YgbAZErJ49mY5OXGKZGk5WTFe
UrhyIQLSsiUgLU5AwrxJZUeppQVfVbNFdB8E4wsJiscIq+Gq1+7HKSo/onUeTSCno9kp6WhO
IjpajIYEzD5RhH4ayopoqA4yRKPsWQXPNq/BWNDyLN8FAeM8qabukikGYkgrZ0OH5wwWIzMU
eZFF98IjQiKULHeV+5sTw/nrjLzjc5IRFTr4FZNq4fe1+3+y2i333RoLiRJAOoZNhteurdNl
Rum7Wk/gBS5TRXdkjTili8WZMognyrmE1JrPYKG/kAaYF+jvttqtC/oKmmsPq1lP0+QW1uSI
PMAQ7loBIX1VbwQpXbmo7x8rK2clqFkGzexLwUuJ3NiSk4nh7TcfqPloWJnCYXyZOCJSTJ8p
OeVTVNqkVy4I5zx/PmP+gyhsiDNt7EanOdQWBcEKAJD08mX+8PLX9fJDTp21JEh87QcpsBlS
YOBQy9btFcdACegsxeXF8+jzgv8PTq/5nF5LjARziiRuZyR4OhcNvHYFkXnt2OHtoeKD3+4N
fjvqGpnqoIP540xI5BZNNiwckg0TymJ4TDZcqCxm63MHE8R29IbPxu94StYhc3gE2cx8LJv5
kGw4he6fDWxU5LJfntUn2tQy0XESl4lzGam4mKpzG8xKKoZT9x1sHvUzXJBcV27xeVdVRw+f
9jwa8+CMb3aHacCPvks+/fq3Y+mqSS0QNPD3bpSv5OIK1Eye8gnnJ7vFRwY8GTr5ali6iwM6
+OGCddTKu8wRCXy2TVPZWIWYACjiwf0TtW3/RxL7ugENkgX4Oay3QlZXDFyva1Z7iuSHxWBm
eK+Yithw7K777zO4VudZfWVZmkyL4ZkSww9NJvbT9U3PAC150GQMUEAMy6OO4/e80/xg4Ryp
YlMluGS/h93L4FRYDPRKxHLnufnShduLnF0hLdA529SijmqSsCGTm+8zbkHKgSzIwdXzgbOv
MBtMZhqXCJcc+Wy8wOX36c95AQVOo/DoSMu3NGYhnLRtD+5PZ9jQbc09DUd/BxkNpBB5GB2w
sHC2Qfe0F8PRrGfi2f0VzoinPgKeAFv2IzZvm8yTDEszfZ2esxOYNrKs8GTSzHHOI5cWy6rb
nhQdpGDWXKmEKTpcAU34tJQ5VGzQyBHADsKMQ0UStrCLykyAiwTdTLXXpE/wipYNveQ1xucv
T7D0BSb+5gyPb67SjEE8voAt0+SyIqQH8fp9+ISgIRiHvfU2oUInbmzHNW0yKVkscfiouk1m
C4DHtGkux1TqWVy/C1AJKglOZvQRzh6njPS4965kUM5FFh2f2ZJB9rMgK8JmFK71kzveRBwT
J9kGEgEm3+1lKUJw9jiJSOKiuVXl1N6trADgRrXUNnMkkzvH9mzNNsnJ9c3dKTHV11nMqXWm
W/FFdOmivSJMTBVhLl0O1Wp4mhx/kDJrJSHWH5p6aMBmRUfRJeLEJIuLFtkk5lpVghbafXsQ
LFO0lMCI0sH2POkZZz3zrPd0SoYXtbk2xDegLBA8HHprFKGUbkOEaf6osoG9ISu8tBHd58rz
dp+bE7t/2dmBls09Ni9GrJaL1n/6qhm6U+rwLFgDZ9picTfbcje3AKVOe9gXEZ8JHxZopqpP
rLu3wHooojtr+wrC5jdurWbLML0MtffRReIwFYRd97EMkk4BfKiVK9xk/si6zhTx8YiyIvKb
EUjO1MfieVmqxmz2OPDE8lKbsjcM65U0cJsKljA9VIobDVCKN55V9lVjkWU7YLkeP3FzA6Ya
M1bJlRWueFCN12xdGmqWJMRmj5OQLC9qXSY2G6pZLdvpBolJFU3DQN2QjGqVu9MN3RcENAck
HYFt98AJITkUp/vQJWHFLSPSnTRvdM8skXRWUryT7EFpttDSytZL019jnJqwnmupvprN3USH
uWDKBCllarVOxAUDKrm4QR7Ntzozt5pcNEfLjEzY3HHykLjlGQrV+ypxbN/DSqbNdaqwqjb0
j8C9h9hP1cdY3xOBVbXJq+9lsoSf8+P5Wfby8wHGJo+jcPG2WemboYHm14XXHV4DAVuZsiTI
R+pY1AxSTyzVJL67aR13xrZEE8P0gWm1lzzr2iAK27nxxKK6/QIqfeaZB0Zq5gHmo+58fHVe
Lovx1WCnU1BeZGl7rN5EQL/REl6JWtKfposP7BW/8bEDPEsQB7bYdfutBr/c/iBfwlDKnf9g
Ghq2z6GWS4nqzi9akCc3sw3ZDpeIk57A7bpXFMtrWNSojO0suMLAiZQiOpjRIBKuiIVmorD7
vnkGD897zRqBbIkEBJZ3HYEsFokILLBbluCuJyJwRHmRi3sRtwwxkrUaEl0kDkVxz6Aooyqd
CkV0N+K5cNtcSRELiiDvR6Ay+yxcKx2DsrQ8XRirT1Tm396WWFBxYjIuC1gKWPkqyQq/GbGg
4lIV4uJe68KYnp65Z1xN9Yxju/IlZzFeV+4IW43oVDNVR93gyGzEY45934qKUJglvITZLv1z
tyK89Mbo0kbGZZ8dtdfLMLlmMH+cZoSF0xuEVEcldtVS3VdLI+HCm5zsO49vJ7oproCdioWt
2QxuckbD9I6KGx+WRa3M62St9+EKcSISd74AsF81wsuhNSFP3hoJ40yYs4sMBnt0b+l+F/Oh
EJCs2U/Uyc4XE1khjkKpuPMoRB2n56D9i74VcRDpT+HVrM5JZo5DGfvgbpv9u6oQUujg62Xv
Q+wlAXf366ff5MUWhP1w3ATx7YwleH+RcRRKaQXUM1iPpfQauIELZxvq3WZx5ETCm1g3yG9K
+egGJfWuSwVmLFazHZo1Gw/WiFOQIO4RH+ew78eggV9K1xuWliiyrjdCWJS9B3zcNLL3wPcX
iaNQKi7Kx8U94uMsGx1UaVQuJNaOd0P4+HIzVPbcIW814aqfDD3zwr3hMuMEOWnX+IU2btlh
xYpl55ZZX46CwvOHvLEdJU211cw0K3kwf5wY+cLyE5NdO2iANy1IdshA3s0M5L986mdpdITz
x8Es8ouBOUXV69M3W48YIy3QN9ch2vcriSg05PStM6ONn0JWsGZ7pDqyn3pFbVPy+5NqWghJ
FX6LLppOFSMbuS+cPtmE4arWWUEW5WClOJ4lYZ8cobIiAwhL0/de5liWggSn70k6L2vlkzUU
w0XiKJSFpaoId/2+REHPIsNqD1q315zq95sbVN9Y9fb29y1CeLMab5ltMlcYbC2+y5A1VLdp
P/yiWrYVSMNFxiFbUDhhXwLwhJUV4faF6ZIeUcgYpxx2PpWL+xGANxyw4zIEIZs9jj5eWKoa
ymwqWMo3KdtUxPcM0/AM0Ir63bY3uBi5jzuM6oIkmdXIYm1IV2ZkbaGNhS0hMs9s76ZWeRZA
6i3di5e7vrkjbMGBarADOYKs7sJkrdIF1h1eOnSjWHvfI13FfecNjWbaCWCwRpx8Fk0RTMlN
r9pADYblkifVMWx/1PeGHQAQMkzHDndS2eyELtysXMBsgmCvgFJaPBX3IBA4LCHB8OuW1tYt
uAXSAuUY2RZiJMFc5peaRFOx+uGeu+jezbgV9sv2i4pY4yL+0CBvpYJizCUSddIZtuaZy9rN
avo645RU3BOTNqxQxdBoedDkLsWkRXMBs3klrB+UxF0srE4BCnZ/yBaKbIU4CPnlugJr2KKo
pWqUPFDvmVKr7wFke2c6YA5sWNgwWnAN3LwEz2RiT95hu1NJWi03r7O92gYP7c4BTRT1Qniq
dw3ybDuPqBBG9YwluAwXZK7Zs9UkLAulJUe+GXLhURiqSRqNP2feIXDdQOYV3CSmMJHXsp1J
RdaoFPjyKuPfY0AOnm9eYyyiN0Q1e/gDWKuPasfQKflqtH2tYyyLaQfbg/JysD8oOyJG/nVM
/pNacF+4gWb1++3n2pfm3f33avNznQQN6tayY2gaImfeIbRZ/Vq5v7z6o3lT+QaXUbvH+Zow
UfAHOH0Rgg88StmSfLhGnOjFTIiepZwRF4ickq4KgLPoRgsuURxkk80iuHaubVIKaoIIaLbI
DNeII1MqHaKsyVFWnjUnnQLY4e4woqBw+2QMRFJIsjdP+wvF8SsvsdtS1daDVqbBcgheBG4o
yULHj2eHSN7cPfgYgMFCLbKW7dzE2lRmzUoIYLQsyrvgyuy7Z8S3Rb9S4djLHPAJRnBpQsP1
LIzgRmObjeDRoidRHnQo2/qq62xAzUrpskV1sEQc1oKckT3MNv0y+ijffHuYw04u/fKnKRsJ
syCHxB8wPQa4IEV7+UAO542jVyweUr+jqd/lcCem0gwWXmm1LQWSEiSGyk8ZG3NUrxoISn70
/GCBG9XRyP++Wm0DlMAP3b+DTxdY6OP6TivfcvrxrBmxaqpWpJ3P8jE7Nn8cu3vQqGW0XVBx
UrsgBDKL6/Msrs/Y6/rcjY/UpJ5t5TX0K17almrq5BPVHhF7D+x4Ub2qX9bq+bbb0vKW6qr5
tv00jDhGflzT6AUTXau+Qy0Qi1XfBPucnsG3H0z774uObXapm9cpNqXQ7Lz/mDjT8OezAzd3
mydPQEG/026PWmfkw7Nqer/ohY/HvGXmu34bbjBvO+2PC1BFUFqdmd8ubaFxOsG+UUvv53hL
gkWnO++2r3qU6SjMv4/NBg5tOdbRliMR54Pi6CyJabhInJDSG6PKjJDkRbZ3B1oa332vtgV6
01xUpXpBsxsO09OAqlbaQ2znRdOBdUwXkUG7qkylcLhEnG3I0pLl776wjVFhLK649eB+bUjI
YvR8scRi9MFxJEa/tnB8o0ODRNUh8PshOBhD0kPyC6vsK1DWY2xC5Cbs/7Vc7eKEKfCnpMqu
ZDf2RGBeGQlroSVM+dwD7eKgW2yaWbICS398qTgTEQoZ2Pr9ZUet/dMdNEykQ7OoHWkWlexI
zpxCUwlTlvehqzgSU1BYBg80aIxTmoHwygrH72RpfSJGWobpZezF6i8xjkN+QhfBXcHhoCS+
jLkT2HcsvdHIGA5LiiTvPA4H1ekZAHA4dxx5fCmbmsZB8fvuVTZGTBt4hpy00l5jb1NP3qiJ
vKWsUZylrHFGehnuFLJsaonMHKcVYeEy98QuEfe27xnYDw5pY5DY3L8CbIkCfDDIcUZy2uBW
sNGtS2RMyJe5qcwdUzuKCubR8etL1+jv5iOUCGFlBNV6I+HKg9m/2o7rkSfgFLCGpZMP8PEB
P124JjV6luHkn1QTc+IN185r5tyZG/3d/7LQQf6/vev7TRQIwu/3V+zTpeZMA4JafPNy16TJ
tfWqfW44SxpSBU7oD//72xlQUFhYYMHl4kurJR2IzuzOfjPfN3vbabdmC/MVTUnL7JX7/mav
nrHfM6Afjr+mJ4nEsEEZtVN5JwsmeLqg0EDz4zZlfWoNSKs5H02WhR+k0ppolEarx5ExoAuC
2KkpDl3p11gHysB/p7OevP1OqPunImVyEM33KRq+SXN8fRBpnpxzo9ZCZCePLTpI9nbTYcIe
jaJhmGgVaiQ72e3ibtUTkwcgfYAURpmAyI+WC67EY2lhr9GYmUbpAgf9cuiljeuuL5d9eGd+
DobRy43rW9FL/COxguVlfrgYxR8d5/+ln5zNzdG4hU9YIca9i/hbvxkFlJ3hdJBUlfNmZFlz
vFHMRMBDBESOvPg/Jto6KHzSSFFGuSM2sflbJ3SzGdLAkgP+yegQqERMUIURE2JRNvGenLCd
dmZdFSr49ogioNtYAvRQ5A0fQ26tt8SpVjEm1MULtFQQCtWQTKlKog4qiB8pyrsD+n2Kh+Mj
q2mPZleC8lP97iDw4KJ40h1BGk9Pr+HItnGeyHKo80mXYO2s83k6+bZmyMFZhGDQ0lCqokGD
rFhY2M6WLAAI8txNkDjvLhaznvzZ/WHPgsoDDSGkCet/i6T3WtgQqQkOkcaPvuXCJaGm3wRS
FBvPCB5DrFj6dE7Cm5FnkwaC6Yei6ZJLpR/K+dPdQ9F55fy1dotpQkq9pYq8jSH8aybCr+Wc
Pav2n91GcH5n2MQRxg/opUGTH+ZCntR40CA5VwddaT6rB2BKtYh7O8EnX3ioJE1nRIohFKWB
URcbi7xE7XIf5haUfrDWa5ELz+57q7733iPxQ/1vAlbAkDa6drwtU41qrG0nYfvYT/Ua7OHs
gRXTGbm2HTuw0PeAsy4xd7hMQQryCyDg01wE8osrOMlKULONDqK1Kre5NmSt38KUIfGxglbT
UaLqQmHKsDAVmMtXsjZth9AQ2GyJ59pO0I2hRUNYi3mOsEMsZqlS6Lax3LwSOqkXOjNS7sYG
Mu7wF7iI//bH3/pPsEIuzdXqAuFxeAeUtnCa1ZP1aQfhheWK3uPNg2vl+Hnka9HjlWbw8Znk
4fjtoZs5REA+y+9AePfu52L2cL+4v5hdP908/JhyS+3+dcWnf2gzvVIMxkJ7oMKGp9/uPM7s
iGO9uIEtI9AF56O55WHxQgH97JweqMPsDuQXRmegS0xdpDTQ1czkhKxpCTRCdEVwhECXuO28
0uzMMV8QQkigw79uZz12x2sYK6dlsqkA8E6GO0FpDlQYRnlq54bBlhPOVSMNgyszO0hEK7LD
NnIIseUzKU64i1SkUEC5fDTR9a6hvq0oT3obd9mA94Zmj913yEIVxn2DfIMfkfMeeUrxfDdW
ORoHcajQD6dpkagXU+Lxzn1Hd4GZk62OnSzCZPu1QNl+1Za5qz7PYD3OlIU35/jYmJ7XQFvG
3m7aJ1Umd17HJVUvV4/GvGN+80BMf+ssSXTjolSjE9P24onDMAWnTdH11lk1nc1tuLpDvvwD
tEhESvAmAQA=

--Nq2Wo0NMKNjxTN9z--
